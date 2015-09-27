class AddTotalToPickUps < ActiveRecord::Migration
  def change
    add_column :pick_ups, :total, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
