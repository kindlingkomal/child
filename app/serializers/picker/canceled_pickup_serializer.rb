class Picker::CanceledPickupSerializer < PickupSerializer
  attributes :id, :address, :city, :pincode, :lat, :lon, :subscription,
    :start_time, :end_time, :category_ids, :total, :status, :reason

  belongs_to :user, serializer: UserCommonSerializer
  belongs_to :customer
  has_many :line_items

  def status
    current_user = @options[:current_user]
    pickup_user = object.pickup_users.find_by(user_id: current_user.try(:id))
    pickup_user.try(:status)
  end

  def reason
    current_user = @options[:current_user]
    pickup_user = object.pickup_users.find_by(user_id: current_user.try(:id))
    pickup_user.try(:reason)
  end

end
