class AddItemTotalToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :item_total, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
