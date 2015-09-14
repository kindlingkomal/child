class PickUp < ActiveRecord::Base
  enum subscription: [:daily, :weekly, :monthly]

  belongs_to :parent
end
