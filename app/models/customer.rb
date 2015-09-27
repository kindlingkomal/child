class Customer < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, uniqueness: true, presence: true
end
