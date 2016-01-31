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
    pick_user = PickupUser.find_or_create_by({
      user_id: current_user.id,
      pick_up_id: pick_up.id,
      status: PickupUser::STATUSES[:canceled],
      is_owner: true
    })
    if pick_up.save
      if (subscription = Subscription.find_by(id: pick_up.subscription_id)) && pick_up.can_update_subscription?(subscription)
        subscription.update canceled_at: pick_up.canceled_at
      end
      gcm_service = GcmService.new(current_user)
      gcm_service.delay.cancel_pickup(pick_up)
    end
    pick_up
  end

  def reschedule params
    pick_up = current_user.pick_ups.find params[:id]
    can_update_subscription = false
    if subscription = Subscription.find_by(id: pick_up.subscription_id)
      can_update_subscription = pick_up.can_update_subscription?(subscription)
    end
    pick_up_param = process_pickup_param(params)
    pick_up.created_at = Time.now
    if pick_up.update_attributes(pick_up_param)
      if can_update_subscription
        subscription.update(frequency: pick_up.frequency, date: pick_up.date,
          time_slot_id: pick_up.time_slot_id,
          start_time: pick_up.start_time, end_time: pick_up.end_time)
      end
    end
    pick_up
  end

private
  def process_pickup_param(params)
    pick_up_param = params.require(:pick_up).permit(:address, :city, :pincode, :lat, :lon,
      :landmark, :subscription, :date, :time_slot_id, category_ids: [])
    # pick_up_param[:category_set] = pick_up_param[:category_set].try(:uniq)
    pick_up_param = pick_up_param.merge(start_time: Util.to_time(pick_up_param[:start_time]))
    pick_up_param = pick_up_param.merge(end_time: Util.to_time(pick_up_param[:end_time]))
    pick_up_param
  end

end
