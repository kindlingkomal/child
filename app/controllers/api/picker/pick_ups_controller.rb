class Api::Picker::PickUpsController < Api::PickerController
  before_action :init_service

  def create
    @result = @service.add_customer(params)
    if @result.blank?
      render json: {error: {code: 4000, msg: "could not add customer"}}, status: 405
    elsif @result.errors.any?
      render json: {error: {code: 4000, msg: @result.errors.full_messages.join(', ')}}, status: 405
    else
      render json: @result, serializer: ::Picker::PickupSerializer
    end

  end

  def show
    @pick_up = current_user.pick_ups.find params[:id]
    render json: @pick_up, serializer: User::PickupSerializer
  end

  def pending
    # date = Date.today
    # if params[:date]
    #   date = Util.to_datetime(params[:date])
    # end
    ex_ids = [-1]
    ex_ids = PickupUser.where(status: [PickupUser::STATUSES[:canceled], PickupUser::STATUSES[:rejected]]).where(user_id: current_user.id).pluck('pick_up_id')
    @pick_ups = PickUp.pending.where("id IS NOT IN (?)", ex_ids)
    @pick_ups = @pick_ups.page(params[:page]).per(params[:per_page] || 10)
    render  json: @pick_ups,
              each_serializer: ::Picker::PickupSerializer,
              meta: {
                total_pages: @pick_ups.total_pages,
                total_pick_ups: @pick_ups.total_count
              },
              root: 'pick_ups'

  end

  def accepted
    # date = Date.today
    # if params[:date]
    #   date = Util.to_datetime(params[:date])
    # end
    @pick_ups = PickUp.where(ragpicker_id: current_user.id)
    @pick_ups = @pick_ups.page(params[:page]).per(params[:per_page] || 10)
    render  json: @pick_ups,
              each_serializer: ::Picker::PickupSerializer,
              meta: {
                total_pages: @pick_ups.total_pages,
                total_pick_ups: @pick_ups.total_count
              },
              root: 'pick_ups'
  end

  def reject
    @result = @service.reject(params)
    if @result.errors.any?
      render json: {error: {code: 4000, msg: @result.errors.full_messages.join(', ')}}, status: 405
    else
      render json: {success: true}
    end
  end

  def accept
    @result = @service.accept(params)
    if @result.errors.any?
      render json: {error: {code: 4000, msg: @result.errors.full_messages.join(', ')}}, status: 405
    else
      render json: {success: true}
    end
  end

  def cancel
    @result = @service.cancel(params)
    if @result.errors.any?
      render json: {error: {code: 4000, msg: @result.errors.full_messages.join(', ')}}, status: 405
    else
      render json: {success: true}
    end
  end

  def proceed
    @result = @service.proceed(params)
    if @result.errors.any?
      render json: {error: {code: 4000, msg: @result.errors.full_messages.join(', ')}}, status: 405
    else
      render json: {success: true}
    end
  end

private

  def init_service
    @service = ::Picker::PickupService.new(current_user)
  end

end
