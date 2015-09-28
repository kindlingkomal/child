class PickupService
  def self.proceed(pick_up, params)
    params[:line_items].each do |item|
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
end
