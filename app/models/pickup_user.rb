class PickupUser < ActiveRecord::Base
  include ArelHelpers::ArelTable

  validates :user_id, presence: true, uniqueness: {scope: :pick_up_id}

  belongs_to :pick_up
  belongs_to :user
end
