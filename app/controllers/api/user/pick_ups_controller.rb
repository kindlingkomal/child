class Api::User::PickUpsController < Api::UserController
  before_action :init_service

  def show
    @pick_up = current_user.pick_ups.find params[:id]
    render json: @pick_up, serializer: User::PickupSerializer
  end

  def upcoming
    @pick_ups = current_user.pick_ups.pending
    @pick_ups = @pick_ups.page(params[:page]).per(params[:per_page] || 10)
    render  json: @pick_ups,
              each_serializer: User::PickupSerializer,
              meta: {
                total_pages: @pick_ups.total_pages,
                total_pick_ups: @pick_ups.total_count
              },
              root: 'pick_ups'

  end

  def history
    @pick_ups = current_user.pick_ups
    @pick_ups = @pick_ups.page(params[:page]).per(params[:per_page] || 10)
    render  json: @pick_ups,
              each_serializer: User::PickupSerializer,
              meta: {
                total_pages: @pick_ups.total_pages,
                total_pick_ups: @pick_ups.total_count
              },
              root: 'pick_ups'
  end

  # def index
  #   @pick_ups = current_user.pick_ups
  #   @pick_ups = @pick_ups.page(params[:page]).per(params[:per_page] || 10)
  # end

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


  def update
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
