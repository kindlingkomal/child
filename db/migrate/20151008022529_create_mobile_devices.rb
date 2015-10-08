class CreateMobileDevices < ActiveRecord::Migration
  def change
    create_table :mobile_devices do |t|
      t.integer :user_id
      t.string :platform
      t.boolean :disabled
      t.string :uid

      t.timestamps null: false
    end
  end
end
