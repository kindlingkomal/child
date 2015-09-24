class AddGcmRegistrationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gcm_registration, :string
    add_index :users, :gcm_registration
  end
end
