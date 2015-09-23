class Api::Ragpicker::PickUpsController < Api::ApiController
  before_action :load_pick_up

  def accept
    now = Time.now.utc
    return if handle_errors_before_accept
    if @pick_up.update(accepted_at: now)
      @pick_up.accepted_users.create(user: @current_user, accepted_at: now)
      render json: @pick_up
    else
      handle_errors_accept
    end
  end

  def cancel
    @accepted_user = @pick_up.accepted_users.
      where(pickup_users: { user_id: @current_user,
        accepted_at: @pick_up.accepted_at, canceled_at: nil
      }).first
    if @accepted_user
      @accepted_user.update(canceled_at: Time.now.utc)
      @pick_up.update(accepted_at: nil)
      render json: @pick_up, meta: { canceled_at: @accepted_user.canceled_at.to_i }
    else
      render json: {error: {code: 20000, msg: "This pick-up cannot canceled"}}, status: 405
    end
  end

private
  def load_pick_up
    @pick_up = PickUp.find_by(id: params[:id])
  end

  def handle_errors_before_accept
    array = if @pick_up.start_time.utc < Time.now.utc
      code, msg, start_time = [10000, "This pick-up cannot be accepted",
        @pick_up.start_time.to_i]
      render json: {error: {code: code, msg: msg, start_time: start_time}}, status: 405
    elsif @pick_up.accepted_at?
      code, msg = [10001, "This pick-up had been accepted",
        @pick_up.start_time.to_i]
      render json: {error: {code: code, msg: msg}}, status: 405
    end
    array.blank? ? nil : array[0]
  end

  def handle_errors_accept
    code, msg = [90002, @pick_up.errors.full_messages.join('. ')]
    render json: {error: {code: code, msg: msg}}, status: 405
  end
end
