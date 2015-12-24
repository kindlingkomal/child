class Category < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, :numericality => {:greater_than => 0}

  has_many :line_items, dependent: :destroy
end
