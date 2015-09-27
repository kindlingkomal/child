class LineItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :pick_up

  validates :category, :pick_up, presence: true
  validates :category_id, uniqueness: {scope: :pick_up_id}
end
