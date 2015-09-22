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
