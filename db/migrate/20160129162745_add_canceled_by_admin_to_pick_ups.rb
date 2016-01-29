class AddCanceledByAdminToPickUps < ActiveRecord::Migration
  def change
    add_column :pick_ups, :canceled_by_admin, :boolean, default: false
  end
end
