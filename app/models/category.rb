class Category < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  strip_attributes :only => [:name]

  validates :name, presence: true, uniqueness: { case_sensitive:  false }
  validates :price, presence: true, :numericality => {:greater_than => 0}

  has_many :line_items, dependent: :destroy
end
