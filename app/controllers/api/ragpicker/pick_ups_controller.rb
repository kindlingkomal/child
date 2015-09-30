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
      @accepted_user.update(accepted_at: nil, canceled_at: Time.now.utc, reason: params[:reason])
      @pick_up.update(accepted_at: nil)
      render json: @pick_up, meta: { canceled_at: @accepted_user.canceled_at.to_i, reason: @accepted_user.reason }
    else
      render json: {error: {code: 20000, msg: "This pick-up cannot be canceled",
        accepted_at: @pick_up.accepted_at.try(:to_i)}}, status: 405
    end
  end

  def reject
    now = Time.now.utc
    return if handle_errors_before_reject
    @rejected_user = @pick_up.rejected_users.create(user: @current_user, rejected_at: now)
    if @rejected_user.errors.blank?
      render json: @pick_up, meta: { rejected_at: @rejected_user.rejected_at.to_i }
    else
      handle_errors_reject(@rejected_user)
    end
  end

  def proceed
    unless @pick_up.can_proceed?(@current_user)
      render json: {error: {code: 10101, msg: 'invalid action'}}, status: 405 and return
    end
    if PickupService.proceed(@pick_up, params)
      render json: @pick_up
    else
      render json: {error: {code: 10100, msg: @pick_up.errors.full_messages.join('. ')}}, status: 405
    end
  end

  def add_customer
    @pick_up = PickupService.add_customer(@current_user, params)
    if @pick_up && @pick_up.errors.blank?
      render json: @pick_up
    else
      render json: {error: {code: 10100, msg: @pick_up.errors.full_messages.join('. ')}}, status: 405
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

  def handle_errors_before_reject
    array = if @pick_up.start_time.utc < Time.now.utc
      code, msg, start_time = [10002, "This pick-up cannot be rejected",
        @pick_up.start_time.to_i]
      render json: {error: {code: code, msg: msg, start_time: start_time}}, status: 405
    end
    array.blank? ? nil : array[0]
  end

  def handle_errors_reject(rejected_user)
    code, msg = [90003, rejected_user.errors.full_messages.join('. ')]
    render json: {error: {code: code, msg: msg}}, status: 405
  end
end
