class Customer < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true

  has_many :pick_ups
end
