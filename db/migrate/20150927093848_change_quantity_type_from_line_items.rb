class ChangeQuantityTypeFromLineItems < ActiveRecord::Migration
  def change
    change_column :line_items, :quantity, :float
  end
end
