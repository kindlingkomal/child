class PickUpSerializer < ActiveModel::Serializer
  attributes :id, :address, :city, :pincode, :subscription,
    :start_time, :end_time, :category_set

  def category_set
    Category.where(id: object.category_set).as_json(only: [:id, :name, :price])
  end

  def start_time
    !object.start_time? ? nil : object.start_time.to_i
  end

  def end_time
    !object.end_time? ? nil : object.end_time.to_i
  end
end
