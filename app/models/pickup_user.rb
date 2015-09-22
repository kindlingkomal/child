class PickupUser < ActiveRecord::Base
  belongs_to :pick_up
  belongs_to :user
end
