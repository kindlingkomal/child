class PricingZonal < ActiveRecord::Base
  belongs_to :category
  belongs_to :zonal

  validates :category_id, presence: true
  validates :zonal_id, presence: true, uniqueness: {scope: :category_id}
  validates :price, presence: true
  
end
