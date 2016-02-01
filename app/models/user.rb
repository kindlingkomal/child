class User < ActiveRecord::Base
  enum role: [:user, :ragpicker, :admin]
  enum gender: [:male, :female]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => {phone_number: true}
  ratyrate_rateable 'customer', 'ragpicker' #, 'experience'
  ratyrate_rater

  include TokenAuthenticatable

  validates :full_name, presence: true, length: { maximum: 26 }
  validates :authentication_token, uniqueness: true, allow_blank: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A([0]|\+91)?[789]\d{9}\z/ }

  has_many :pick_ups, dependent: :destroy
  has_many :pickup_users, dependent: :destroy
  has_many :invitations, dependent: :destroy, foreign_key: :invited_by_id
  has_many :user_invitations, dependent: :destroy, class_name: 'Invitation'
  has_many :notifying_pickups, dependent: :destroy, foreign_key: :ragpicker_id
  has_many :accepted_pick_ups, class_name: 'PickUp', foreign_key: :ragpicker_id

  before_validation :set_default_role, :if => :new_record?
  before_validation :set_default
  before_destroy :remove_ratings

  mount_uploader :avatar, AvatarUploader

  reverse_geocoded_by :lat, :lon

  scope :ragpickers, -> {where(role: 1)}
  scope :active, -> { where(inactive: false) }

  def active?
   !inactive
  end

  def near_ragpickers
    User.ragpicker.near([lat, lon], 5, :units => :km)
  end

  def activate_and_invalidate_authentication_token
    if encrypted_password?
      invalidate_authentication_token!
      update(inactive: false, otp: nil)
    end
  end

private
  # override a method in gem devise
  def email_required?
    !(user? || ragpicker?)
  end

  def set_default
    if self.role == '1'
      str = phone_number
      str = "+#{str}" if str.index('91') == 0
      str = "+91#{str}" if str.index("+91") != 0
      self.phone_number = str
    end
  end

  def set_default_role
    self.role ||= :user
  end

  def remove_ratings
    self.ratings_given.destroy_all
  end
end
