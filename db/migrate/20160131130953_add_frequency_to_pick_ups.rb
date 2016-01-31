class AddFrequencyToPickUps < ActiveRecord::Migration
  def change
    add_column :pick_ups, :frequency, :integer
  end
end
