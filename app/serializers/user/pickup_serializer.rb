class User::PickupSerializer < PickupSerializer
  attributes :id, :address, :city, :pincode, :lat, :lon, :landmark, :subscription,
    :start_time, :end_time, :pick_time, :category_ids, :status, :total, :has_ratings

  # belongs_to :user, serializer: UserCommonSerializer
  belongs_to :ragpicker, serializer: UserCommonSerializer
  has_many :line_items

  def pick_time
    object.pick_time
  end
end
