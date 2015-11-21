class AddLandmarkToPickUps < ActiveRecord::Migration
  def change
    add_column :pick_ups, :landmark, :string
  end
end
