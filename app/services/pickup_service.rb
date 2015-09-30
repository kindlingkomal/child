class PickupService
  def self.proceed(pick_up, params)
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
  end

  def self.add_customer(current_user, params)
    customer_params = params[:customer]
    customer = Customer.find_or_create_by(
      name: customer_params[:name].try(:strip),
      phone_number: customer_params[:phone_number].try(:strip)
    )
    return nil unless customer
    pick_up = customer.pick_ups.create handle_pick_up_params(params).
      merge(customer_id: customer.id, user_id: current_user.id, accepted_at: Time.now.utc)
    return pick_up if pick_up.errors.any?
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

private
  def self.permit_pick_up_params(params)
    params.require(:pick_up).permit(:start_time, :end_time)
  end

  def self.handle_pick_up_params(params)
    pick_up_params = permit_pick_up_params(params)
    # params[:pick_up][:category_set] = params[:pick_up][:category_set].try(:uniq)
    attrs = pick_up_params.merge(start_time: Util.to_time(pick_up_params[:start_time]))
    attrs = attrs.merge(end_time: Util.to_time(pick_up_params[:end_time]))
  end
end
