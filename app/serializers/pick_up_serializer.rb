class PickUpSerializer < ActiveModel::Serializer
  attributes :id, :address, :city, :pincode, :lat, :lon, :subscription,
    :start_time, :end_time, :category_set, :status, :accepted_at

  belongs_to :user

  def category_set
    Category.where(id: object.category_set).as_json(only: [:id, :name, :price])
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

  def status
    if object.accepted_at?
      'accepted'
    elsif object.accepted_users.count > 0 &&
      object.accepted_users.where(pickup_users: {canceled_at: nil}).count == 0
      'canceled'
    elsif Time.now.utc < object.start_time
      'pending'
    else
      'expired'
    end
  end
end
