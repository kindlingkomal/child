class Zonal < ActiveRecord::Base
  validates :zipcode, presence: true, uniqueness: true

  def name
    zipcode
  end
end
