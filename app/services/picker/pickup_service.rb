class Picker::PickupService < BaseService

  def reject params
    pick_up = PickUp.pending.find params[:id]
    pick_user = PickupUser.find_or_create_by({
      user_id: current_user.id,
      pick_up_id: pick_up.id
    })
    pick_user.status = PickupUser::STATUSES[:rejected]
    pick_user.save
    pick_user
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
    pick_up = current_user.accepted_pick_ups.where(status: PickUp::STATUSES[:accepted]).find params[:id]
    # TODO
    line_items = params[:line_items] || []
    if line_items.is_a?(Hash)
      line_items = line_items.values
    end
    puts line_items.inspect
    line_items.each do |item|
      category = Category.find_by(id: item[:category_id])
      pick_up.line_items.
        find_or_create_by(category_id: category.id) do |line_item|
        line_item.name = category.name
        line_item.cost_price = category.price
        line_item.quantity = item[:quantity]
      end
    end
    pick_up.update(proceeded_at: Time.now.utc, total: pick_up.line_items.sum(:item_total), status: PickUp::STATUSES[:done])

    pick_up
  end


  def add_customer(params)
    customer_params = params.require(:customer).permit(:name, :phone_number)
    pick_up_params = params.require(:pick_up).permit(:start_time, :end_time)

    customer = Customer.find_or_create_by(
      name: customer_params[:name].try(:strip),
      phone_number: customer_params[:phone_number].try(:strip)
    )
    pick_up_params = pick_up_params.merge({
      customer_id: customer.id,
      user_id: nil,
      accepted_at: Time.now.utc,
      ragpicker_id: current_user.id,
      manual: true,
      status: PickUp::STATUSES[:done]
    })
    return nil unless customer
    pick_up = customer.pick_ups.create(pick_up_params)
    return pick_up if pick_up.errors.any?
    cat_ids = []
    line_items = params[:line_items] || []
    if line_items.is_a?(Hash)
      line_items = line_items.values
    end
    puts line_items.inspect
    line_items.each do |item|
      category = Category.find_by(id: item[:category_id])
      cat_ids.push(category.id)
      pick_up.line_items.find_or_create_by(category_id: category.id) do |line_item|
        line_item.name = category.name
        line_item.cost_price = category.price
        line_item.quantity = item[:quantity]
      end
    end
    pick_up.update(proceeded_at: Time.now.utc, total: pick_up.line_items.sum(:item_total), category_ids: cat_ids)
    pick_up
  end

  def pending params


  end

end
