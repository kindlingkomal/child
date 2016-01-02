class User::PickUpsController < User::BaseController
  layout 'customer'
  before_action :authenticate_user!, only: :create
  before_action :init_service
  load_resource only: [:summary]
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
      render :new
    else
      redirect_to summary_user_pick_up_path(@pick_up)
    end
  end

  def summary
    @selected_category_ids = session[:selected_category_ids]
    @categories = @pick_up ? @pick_up.categories : Category.where(id: @selected_category_ids).order(:name)
  end

private

  def init_service
    @service = User::PickupService.new(current_user)
  end

end
