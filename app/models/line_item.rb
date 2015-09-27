class LineItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :pick_up

  validates :category, :pick_up, presence: true
  validates :category_id, uniqueness: {scope: :pick_up_id}

  before_validation :set_default

private
  def set_default
    self.item_total = quantity * cost_price if quantity? && cost_price?
  end
end
