class RemoveParentIdFromPickUps < ActiveRecord::Migration
  def change
    remove_column :pick_ups, :parent_id, :integer
  end
end
