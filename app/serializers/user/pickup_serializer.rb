class User::PickupSerializer < PickupSerializer
  attributes :id, :address, :city, :pincode, :lat, :lon, :landmark, :subscription,
    :start_time, :end_time, :category_ids, :status, :total, :status

  # belongs_to :user, serializer: UserCommonSerializer
  belongs_to :ragpicker, serializer: UserCommonSerializer
  has_many :line_items


end
