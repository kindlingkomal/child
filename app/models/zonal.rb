class Zonal < ActiveRecord::Base
  has_many :pricing_zonals, dependent: :destroy
  has_many :categories, through: :pricing_zonals

  validates :zipcode, presence: true, uniqueness: true

  accepts_nested_attributes_for :pricing_zonals, :allow_destroy => true

  def name
    zipcode
  end
end
