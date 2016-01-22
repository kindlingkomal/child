class Rate < ActiveRecord::Base
  validates :pick_up_id, presence: true, uniqueness: true, if: proc {|o| o.rater.user? }

  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true
  belongs_to :pick_up

end
