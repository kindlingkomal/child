class Picker::PickupService < BaseService

  def reject params

  end

  def cancel params
    pick_up = current_user.accepted_pick_ups.find params[:id]
    pick_user = PickupUser.find_by({
      user_id: current_user.id,
      status: PickupUser::STATUSES[:accepted],
      pick_up_id: pick_up.id
    })
    pick_user.status = PickupUser::STATUSES[:canceled]
    pick_user.reason = params[:reason]

    pick_up.ragpicker_id = nil
    pick_up.status = PickUp::STATUSES[:pending]

    pick_user.save!
    pick_up.save

    pick_user
  end

  def accept params
    pick_up = PickUp.pending.find params[:id]
    pick_user = PickupUser.find_by({
      user_id: current_user.id,
      pick_up_id: pick_up.id
    })
    if !pick_user
      pick_user = PickupUser.new({
        user_id: current_user.id,
        pick_up_id: pick_up.id
      })
    end
    time = Time.now
    pick_user.status = PickupUser::STATUSES[:accepted]
    pick_user.accepted_at = time
    pick_up.ragpicker_id = current_user.id
    pick_up.accepted_at = time
    pick_up.status = PickUp::STATUSES[:accepted]

    pick_user.save!
    pick_up.save
    pick_up
  end


  def proceed params
    pick_up = current_user.accepted_pick_ups.find params[:id]
    params[:line_items].each do |key, item|
      category = Category.find_by(id: item[:category_id])
      pick_up.line_items.
        find_or_create_by(category_id: category.id) do |line_item|
        line_item.name = category.name
        line_item.cost_price = category.price
        line_item.quantity = item[:quantity]
      end
    end
    pick_up.update(proceeded_at: Time.now.utc, total: pick_up.line_items.sum(:item_total))

    pick_up
  end



end
