class AddAddress2IsYardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address2, :string
    add_column :users, :is_yard, :boolean, default: false
  end
end
