class User < ActiveRecord::Base
  enum role: [:user, :ragpicker, :admin]
  enum gender: [:male, :female]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include TokenAuthenticatable

  validates :full_name, presence: true
  validates :authentication_token, uniqueness: true, allow_blank: true
  validates :phone_number, uniqueness: true, presence: true

  has_many :pick_ups, dependent: :destroy

  before_validation :set_default_role, :if => :new_record?

  reverse_geocoded_by :lat, :lon

  def active?
   !inactive
  end

  def near_ragpickers
    User.ragpicker.near([lat, lon], 5, :units => :km)
  end

private
  # override a method in gem devise
  def email_required?
    false
  end

  def set_default_role
    self.role ||= :user
  end
end
