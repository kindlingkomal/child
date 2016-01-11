class AddYardNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :yard_number, :string
  end
end
