class User::PickupService < BaseService
  # actually, add a subscription/order
  def add params
    pick_up_param = process_pickup_param(params)
    pick_up = current_user.pick_ups.new(pick_up_param)
    pick_up.status = PickUp::STATUSES[:pending]
    pick_up.save
    pick_up
  end

  def cancel params
    pick_up = current_user.pick_ups.find params[:id]
    pick_up.canceled_at = Time.now
    pick_up.status = PickUp::STATUSES[:canceled]
    # pick_up.reason = params[:reason]
    pick_up.save
    pick_up
  end

  def reschedule params
    pick_up = current_user.pick_ups.find params[:id]
    pick_up_param = process_pickup_param(params)
    pick_up.update_attributes(pick_up_param)
    pick_up
  end

private
  def process_pickup_param(params)
    pick_up_param = params.require(:pick_up).permit(:address, :city, :pincode, :lat, :lon,
      :subscription, :start_time, :end_time, category_set: [], category_ids: [])
    pick_up_param[:category_set] = pick_up_param[:category_set].try(:uniq)
    pick_up_param = pick_up_param.merge(start_time: Util.to_time(pick_up_param[:start_time]))
    pick_up_param = pick_up_param.merge(end_time: Util.to_time(pick_up_param[:end_time]))
    pick_up_param
  end

end
