class PickUp < ActiveRecord::Base
  include ArelHelpers::ArelTable
  include ArelHelpers::JoinAssociation
  enum subscription: [:no, :daily, :weekly, :monthly]
  STATUSES = {
    pending: 'pending',
    accepted: 'accepted',
    done: 'done',
    canceled: 'canceled',
    expired: 'expired'
  }
  validates :address, :city, :start_time, :end_time, :category_ids,
    presence: true, if: proc { |o| o.customer_id.nil? }
  validates :user, presence: {if: Proc.new { |pk| !pk.manual?}}

  belongs_to :user
  belongs_to :ragpicker, class_name: 'User'
  belongs_to :customer
  has_many :pickup_users, dependent: :destroy
  has_many :accepted_users, dependent: :destroy
  has_many :rejected_users, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_and_belongs_to_many :categories

  before_validation :set_default_subscription

  scope :pending,  -> { where(status: STATUSES[:pending]).where('pick_ups.start_time > ?', Time.now.utc) }
  scope :accepted, -> { where.not(accepted_at: nil).where(canceled_at: nil) }

  accepts_nested_attributes_for :customer, :line_items

  def manual?
    manual
  end

  def can_proceed?(ragpicker)
    return false unless ragpicker
    proceeded_at.nil? && accepted_at? && accepted_users.
      where(user_id: ragpicker.id, canceled_at: nil).count == 1
  end

  def can_cancel?(seller)
    return false unless seller
    proceeded_at.nil? && canceled_at.nil? && start_time.utc > Time.now.utc
  end

  # def ragpicker
  #   accepted_users.order("accepted_at DESC").first.user rescue nil
  # end

  def pick_time
    "#{start_time.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}" rescue nil
  end


  def ragpicker_name
    if customer_id && user
      user.full_name
    else
      ragpicker.full_name rescue nil
    end
  end

  def customer_name
    if customer
      customer.name
    elsif user
      user.full_name
    end
  end

private
  def set_default_subscription
    self.subscription ||= :no
  end

end
