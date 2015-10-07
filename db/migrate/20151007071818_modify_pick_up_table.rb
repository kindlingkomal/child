class ModifyPickUpTable < ActiveRecord::Migration
  def up
    add_column :pick_ups, :order_id, :integer
    add_column :pick_ups, :ragpicker_id, :integer
    add_column :pick_ups, :code, :string
    add_column :pick_ups, :status, :string
  end

  def down
    remove_column :pick_ups, :order_id
    remove_column :pick_ups, :ragpicker_id
    remove_column :pick_ups, :code
    remove_column :pick_ups, :status
  end
end
