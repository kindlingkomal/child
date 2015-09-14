class CreatePickUps < ActiveRecord::Migration
  def change
    create_table :pick_ups do |t|
      t.string :pincode
      t.string :city
      t.string :address
      t.references :parent, references: :pick_ups, index: true, foreign_key: true
      t.integer :subscription
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :accepted_at
      t.datetime :started_at
      t.datetime :proceeded_at
      t.text :category_set, array: true, default: []

      t.timestamps null: false
    end
  end
end
