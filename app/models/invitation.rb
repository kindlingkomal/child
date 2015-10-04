class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :invited_by, class_name: 'User'

  validates :name, presence: true
  validates :phone_number, uniqueness: true, presence: true
end
