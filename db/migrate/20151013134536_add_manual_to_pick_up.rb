class AddManualToPickUp < ActiveRecord::Migration
  def change
    add_column :pick_ups, :manual, :boolean, default: false
  end
end
