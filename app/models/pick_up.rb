class PickUp < ActiveRecord::Base
  enum subscription: [:daily, :weekly, :monthly]

  validates :address, :city, :start_time, :end_time, :category_set, presence: true

  belongs_to :parent
end
