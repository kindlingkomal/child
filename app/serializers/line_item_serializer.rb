class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost_price, :quantity

  belongs_to :category

end
