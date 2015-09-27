class Category < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validates :name, :price, presence: true
  validates :price, :numericality => {:greater_than => 0}

  has_many :line_items, dependent: :destroy
end
