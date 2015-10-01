class AddCanceledAtToPickUps < ActiveRecord::Migration
  def change
    rename_column(:pick_ups, :started_at, :canceled_at)
  end
end
