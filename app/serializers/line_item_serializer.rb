class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost_price, :quantity, :item_total, :category_id

end
