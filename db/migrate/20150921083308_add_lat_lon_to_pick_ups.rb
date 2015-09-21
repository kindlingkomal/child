class AddLatLonToPickUps < ActiveRecord::Migration
  def change
    add_column :pick_ups, :lat, :float
    add_column :pick_ups, :lon, :float
    add_index :pick_ups, [:lat, :lon]
  end
end
