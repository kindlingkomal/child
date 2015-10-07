class AddStatusToPickupUser < ActiveRecord::Migration
  def change
    add_column :pickup_users, :status, :string
  end
end
