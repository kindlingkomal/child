class AddDateToPickUps < ActiveRecord::Migration
  def change
    add_column :pick_ups, :date, :Date
  end
end
