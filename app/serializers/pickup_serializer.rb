class PickupSerializer < ActiveModel::Serializer
  attributes :id, :address, :city, :pincode, :lat, :lon,
    :start_time, :end_time, :category_set, :status, :accepted_at, :total, :status

  def category_set
    Category.where(id: object.category_set).map {|cat|
      CategorySerializer.new(cat).attributes
    }
  end

  def start_time
    !object.start_time? ? nil : object.start_time.to_i
  end

  def end_time
    !object.end_time? ? nil : object.end_time.to_i
  end

  def accepted_at
    !object.accepted_at? ? nil : object.accepted_at.to_i
  end

end
