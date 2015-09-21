class Api::PickUpsController < Api::ApiController

  def create
    @pick_up = PickUp.new handle_params
    @pick_up.user = @current_user
    if @pick_up.save
      render json: @pick_up
    else
      handle_errors_create
    end
  end

private
  def pick_up_params
    params.require(:pick_up).permit(:address, :city, :pincode, :lat, :lon,
      :subscription, :start_time, :end_time, category_set: [])
  end

  def handle_errors_create
    code, msg = [90002, @pick_up.errors.full_messages.join('. ')]
    render json: {error: {code: code, msg: msg}}, status: 405
  end

  def handle_params
    params[:pick_up][:category_set] = params[:pick_up][:category_set].try(:uniq)
    attrs = pick_up_params.merge(start_time: to_time(pick_up_params[:start_time]))
    attrs = attrs.merge(end_time: to_time(pick_up_params[:end_time]))
  end

  def to_time(epoch)
    epoch = epoch.to_i
    return nil if epoch == 0
    Time.at(epoch) rescue nil
  end
end
