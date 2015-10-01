class PickUp < ActiveRecord::Base
  include ArelHelpers::ArelTable
  include ArelHelpers::JoinAssociation
  enum subscription: [:no, :daily, :weekly, :monthly]

  validates :address, :city, :start_time, :end_time, :category_set,
    presence: true, if: proc { |o| o.customer_id.nil? }
  validates :user, presence: true

  belongs_to :user
  belongs_to :customer
  has_many :pickup_users, dependent: :destroy
  has_many :accepted_users, dependent: :destroy
  has_many :rejected_users, dependent: :destroy
  has_many :line_items, dependent: :destroy

  before_validation :set_default_subscription

  scope :pending,  -> { where(accepted_at: nil).where('start_time > ?', Time.now.utc) }
  scope :accepted, -> { where.not(accepted_at: nil).where(canceled_at: nil) }

  def can_proceed?(ragpicker)
    return false unless ragpicker
    proceeded_at.nil? && accepted_at? && accepted_users.
      where(user_id: ragpicker.id, canceled_at: nil).count == 1
  end

  def can_cancel?(seller)
    return false unless seller
    proceeded_at.nil? && canceled_at.nil? && start_time.utc > Time.now.utc
  end

private
  def set_default_subscription
    self.subscription ||= :no
  end

end
