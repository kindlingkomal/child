class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :pincode
      t.string :city
      t.string :address
      t.integer :frequency
      t.datetime :start_time
      t.datetime :end_time
      t.text :category_set, array: true, default: []
      t.float :lat
      t.float :lon
      t.references :user, index: true, foreign_key: true
      t.string :landmark
      t.string :payment_method
      t.references :time_slot, index: true, foreign_key: true
      t.date :date

      t.timestamps null: false
    end
    add_index :subscriptions, [:lat, :lon]
  end
end
