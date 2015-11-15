class NotifyingPickup < ActiveRecord::Base
  belongs_to :pick_up
  belongs_to :ragpicker, class_name: :User

  validates :pick_up, :ragpicker, presence: true

  before_validation :set_sent_at

private
  def set_sent_at
    self.sent_at ||= Time.now.utc
  end
end
