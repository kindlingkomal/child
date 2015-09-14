class Api::PickUpsController < Api::ApiController

  def create
    params[:pick_up][:category_set] = params[:pick_up][:category_set].uniq
    @pick_up = PickUp.new pick_up_params
    if @pick_up.save
      render json: @pick_up
    else
      handle_errors_create
    end
  end

private
  def pick_up_params
    params.require(:pick_up).permit(:address, :city, :pincode, :subscription,
      :start_time, :end_time, category_set: [])
  end

  def handle_errors_create
    code, msg = [90002, @pick_up.errors.full_messages.join('. ')]
    render json: {error: {code: code, msg: msg}}, status: 405
  end

end
