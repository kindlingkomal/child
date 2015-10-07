class Order < ActiveRecord::Base
  REPEATS = {
    none: 'none',
    daily: 'daily',
    weekly: 'weekly',
    monthly: 'monthly'
  }
  belongs_to :user
  has_many :pick_ups
end
