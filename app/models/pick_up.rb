class PickUp < ActiveRecord::Base
  include ArelHelpers::ArelTable
  include ArelHelpers::JoinAssociation
  enum subscription: [:no, :daily, :weekly, :monthly] # will remove
  as_enum :frequency, [:no, :daily, :weekly, :monthly], prefix: true, source: 'frequency'
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
  validates :pincode, length: { is: 6 }, format: {with: /\d{6}/}
  validates :date, presence: true
  validates :time_slot_id, presence: true, uniqueness: {scope: [:user_id, :date]}, if: Proc.new { |pk| !pk.manual?}
  validate :check_start_time

  belongs_to :time_slot
  belongs_to :user
  belongs_to :ragpicker, class_name: 'User'
  belongs_to :customer

  has_many :pickup_users, dependent: :destroy
  has_many :accepted_users, dependent: :destroy
  has_many :rate_list, dependent: :destroy, class_name: 'Rate'
  has_many :rejected_users, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :notifying_pickups, dependent: :destroy
  has_and_belongs_to_many :categories

  before_validation :set_default_frequency, :set_time, :set_time_slot_id, :set_date
  after_create :create_subscription

  scope :pending,  -> { where(status: STATUSES[:pending]).where('pick_ups.start_time > ?', Time.now.utc) }
  scope :accepted, -> { where.not(accepted_at: nil).where(canceled_at: nil) }

  accepts_nested_attributes_for :customer, :line_items

  ransacker :with_status_by_partners, formatter: proc { |selected|
      if selected == PickupUser::STATUSES[:rejected]
        pickup_ids = PickupUser.where(status: selected).map(&:pick_up_id)
        results = PickUp.where('pick_ups.status=? OR pick_ups.id IN (?)', selected, pickup_ids).map(&:id)
      else
        results = PickUp.where(status: selected).map(&:id)
      end
      results = results.present? ? results : nil
    }, splat_params: true do |parent|
    parent.table[:id]
  end

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

  def can_update_subscription?(subscription)
    date == subscription.date && time_slot_id == subscription.time_slot_id
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
  def set_default_frequency
    self.frequency ||= subscription
    self.subscription ||= :no
    self.frequency ||= :no
  end

  def set_time
    if date.present? && time_slot_id.present?
      start_date = date.to_date
      timeslot = TimeSlot.find time_slot_id
      self.start_time = start_date + timeslot.start_hour.seconds
      self.end_time = start_date + timeslot.end_hour.seconds
    else
      self.date = nil
      self.time_slot_id = nil
    end
  end

  def set_time_slot_id
    unless time_slot_id?
      opts = TimeSlotService.options_for_select
      opt = opts.select{|o| pick_time  == o[0]}.first
      self.time_slot_id = opt ? opt[1] : nil
    end
  end

  def set_date
    if !date? && start_time?
      self.date = start_time.to_date
    end
  end

  def check_start_time
    if %w(pending accepted).include?(status) && start_time < Time.zone.now
      errors.add(:base, "Start time cannot be in the past")
    end
  end

  def create_subscription
    if user_id? && !manual && status == PickUp::STATUSES[:pending] && start_time > Time.zone.now
      sub = Subscription.create(pincode: pincode, city: city, address: address,
        start_time: start_time, end_time: end_time, lat: lat, lon: lon, frequency: frequency,
        user_id: user_id, landmark: landmark, payment_method: payment_method, date: date,
        time_slot_id: time_slot_id, category_set: category_ids)
      update(subscription_id: sub.id) if sub.errors.blank?
    end
  end
end
