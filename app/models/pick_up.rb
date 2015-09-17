class PickUp < ActiveRecord::Base
  enum subscription: [:daily, :weekly, :monthly]

  validates :address, :city, :start_time, :end_time, :category_set, presence: true

  belongs_to :parent

  scope :pending,  -> { where(accepted_at: nil)}
  scope :accepted, -> { where.not(accepted_at: nil)}
end
