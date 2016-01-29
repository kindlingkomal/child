class AddIsOwnerToPickupUsers < ActiveRecord::Migration
  def change
    add_column :pickup_users, :is_owner, :boolean, default: false
  end
end
