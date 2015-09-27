class Api::Ragpicker::LineItemsController < Api::ApiController

  def add
    @pick_up = PickUp.find_by(id: line_item_params[:pick_up_id])
    render json: {error: {code: 10101, msg: 'invalid action'}}, status: 405 and return unless @pick_up
    @line_item = @pick_up.line_items.
      find_or_create_by(category_id: line_item_params[:category_id])
    category = @line_item.category
    @line_item.update quantity: line_item_params[:quantity],
      name: category.name, cost_price: category.price
    render json: @line_item, meta: { pickup_total: @pick_up.line_items.sum(:item_total) }
  end

private
  def line_item_params
    params.require(:line_item).permit(:category_id, :pick_up_id, :quantity)
  end

end
