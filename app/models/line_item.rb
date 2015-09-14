class LineItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :pick_up
end
