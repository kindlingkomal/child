class PickUpSerializer < ActiveModel::Serializer
  attributes :id, :address, :city, :pincode, :subscription,
    :start_time, :end_time, :category_set

  def category_set
    Category.where(id: object.category_set).as_json(only: [:id, :name, :price])
  end
end
