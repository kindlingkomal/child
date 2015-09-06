class AddMissingColsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :integer
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :notified, :boolean, default: false
    add_column :users, :pincode, :string
  end
end
