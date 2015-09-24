class PickupUser < ActiveRecord::Base
  include ArelHelpers::ArelTable

  belongs_to :pick_up
  belongs_to :user
end
