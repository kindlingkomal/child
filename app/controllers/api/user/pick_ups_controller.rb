class Api::User::PickUpsController < Api::UserController
  before_action :init_service

  def show
    @pick_up = current_user.pick_ups.find params[:id]
    render json: @pick_up
  end

  def index
    @pick_ups = current_user.pick_ups
    @pick_ups = @pick_ups.page(params[:page]).per(params[:per_page] || 10)
  end

  # POST /api/user/pick_ups
  # add new order/subscription
  def create
    result = @service.add(params)
    if result.errors.any?
      code, msg = [90002, @pick_up.errors.full_messages.join('. ')]
      render json: {error: {code: code, msg: msg}}, status: 405
    else
      render json: result
    end
  end


  def cancel
    result = @service.cancel(params)
    if result.errors.any?
      code, msg = [90002, result.errors.full_messages.join('. ')]
      render json: {error: {code: code, msg: msg}}, status: 405
    else
      render json: result
    end
  end


  def reschedule
    result = @service.reschedule(params)
    if result.errors.any?
      code, msg = [90002, result.errors.full_messages.join('. ')]
      render json: {error: {code: code, msg: msg}}, status: 405
    else
      render json: result
    end
  end


private

  def init_service
    @service = User::PickupService.new(current_user)
  end

end
