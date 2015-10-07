class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :zipcode
      t.string :city
      t.string :address
      t.string :repeat
      t.date :pick_date
      t.datetime :pick_from_time
      t.datetime :pick_to_time
      t.float :lat
      t.float :lon
      t.boolean :inactive, default: false
      # t.integer :pickups_count, default: 0

      t.timestamps null: false
    end
  end
end
