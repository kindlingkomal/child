class Subscription < ActiveRecord::Base
  enum frequency: [:no, :daily, :weekly, :monthly]

  validates :pincode, length: { is: 6 }, format: {with: /\d{6}/}
  validates :address, :city, :start_time, :end_time, :category_set, presence: true
  validates :user, presence: true
  validates :date, presence: true
  validates :time_slot_id, presence: true, uniqueness: {scope: [:user_id, :date]}
  validate :check_start_time

  belongs_to :user
  belongs_to :time_slot

  before_validation :set_default_frequency, :set_time

private

  def set_default_frequency
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

  def check_start_time
    if start_time < Time.zone.now
      errors.add(:start_time, "Start time cannot be in the past")
    end
  end
end
