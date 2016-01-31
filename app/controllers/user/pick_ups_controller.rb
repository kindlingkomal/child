class User::PickUpsController < User::BaseController
  layout 'customer'
  before_action :authenticate_user!, only: [:create, :manage, :reschedule]
  before_action :init_service
  load_resource only: [:summary, :reschedule, :book]
  authorize_resource

  def new
    @pick_up = PickUp.new
    @selected_category_ids = params[:category_ids]
    session[:selected_category_ids] = @selected_category_ids
  end

  def create
    @category_ids = params[:pick_up][:category_ids]
    @pick_up = @service.add(params)
    # puts @pick_up.errors.inspect
    if @pick_up.errors.any?
      @selected_category_ids = session[:selected_category_ids]
      render :new
    else
      session.delete(:selected_category_ids)
      redirect_to summary_user_pick_up_path(@pick_up)
    end
  end

  def summary
    if params[:category_ids].nil?
      @selected_category_ids = session[:selected_category_ids]
    else
      @selected_category_ids = params[:category_ids]
      session[:selected_category_ids] = @selected_category_ids
    end
    @selected_categories = @pick_up ? @pick_up.categories.order(:name) : Category.where(id: @selected_category_ids).order(:name)
  end

  def manage
    @upcoming_pick_ups = current_user.pick_ups.
      where(status: [PickUp::STATUSES[:accepted], PickUp::STATUSES[:pending]]).
      where("start_time > ?", Time.now).order(start_time: :asc)
    @history_pick_ups = current_user.pick_ups.
      where(status: [PickUp::STATUSES[:done], PickUp::STATUSES[:canceled]]).order(start_time: :asc)
  end

  def cancel
    result = @service.cancel(params)
    redirect_to manage_user_pick_ups_path
  end

  def book
    @pick_up = @service.reschedule params
    if @pick_up.errors.blank?
      redirect_to summary_user_pick_up_path(@pick_up)
    else
      render :reschedule
    end
  end

  def reschedule
  end

private

  def init_service
    @service = User::PickupService.new(current_user)
  end

end
