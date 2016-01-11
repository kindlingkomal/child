class AddHasRatingsToPickUps < ActiveRecord::Migration
  def change
    add_column :pick_ups, :has_ratings, :boolean, default: false
  end
end
