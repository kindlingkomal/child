class PickupUser < ActiveRecord::Base
  include ArelHelpers::ArelTable
  STATUSES = {
    rejected: 'rejected',
    canceled: 'canceled',
    accepted: 'accepted'
  }
  
  validates :user_id, presence: true, uniqueness: {scope: :pick_up_id}

  belongs_to :pick_up
  belongs_to :user
end
