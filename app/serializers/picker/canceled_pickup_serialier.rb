class Picker::CancledPickupSerializer < PickupSerializer
  attributes :id, :address, :city, :pincode, :lat, :lon, :subscription,
    :start_time, :end_time, :category_ids, :status, :total, :status

  # belongs_to :user, serializer: UserCommonSerializer
  belongs_to :user, serializer: UserCommonSerializer
  belongs_to :customer
  has_many :line_items


end
