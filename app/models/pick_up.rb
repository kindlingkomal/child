class PickUp < ActiveRecord::Base
  include ArelHelpers::ArelTable
  include ArelHelpers::JoinAssociation
  enum subscription: [:no, :daily, :weekly, :monthly]

  validates :address, :city, :start_time, :end_time, :category_set, presence: true
  validates :user, presence: true

  belongs_to :user
  belongs_to :parent, class_name: 'PickUp'
  has_one :child, :class_name => 'PickUp', foreign_key: 'parent_id'
  has_many :pickup_users, dependent: :destroy
  has_many :accepted_users, dependent: :destroy
  has_many :rejected_users, dependent: :destroy
  has_many :line_items, dependent: :destroy

  scope :pending,  -> { where(accepted_at: nil).where('start_time > ?', Time.now.utc) }
  scope :accepted, -> { where.not(accepted_at: nil)}

  def can_start?(ragpicker)
    return false unless ragpicker
    started_at.nil? && accepted_at? && accepted_users.
      where(user_id: ragpicker.id, canceled_at: nil).count == 1
  end

  def can_be_done?(ragpicker)
    return false unless ragpicker
    proceeded_at.nil? && accepted_at? && accepted_users.
      where(user_id: ragpicker.id, canceled_at: nil).count == 1
  end

end
