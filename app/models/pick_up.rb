class PickUp < ActiveRecord::Base
  enum subscription: [:daily, :weekly, :monthly]

  validates :address, :city, :start_time, :end_time, :category_set, presence: true

  belongs_to :parent, class_name: 'PickUp'
  has_one :child, :class_name => 'PickUp', foreign_key: 'parent_id'

  scope :pending,  -> { where(accepted_at: nil)}
  scope :accepted, -> { where.not(accepted_at: nil)}
end
