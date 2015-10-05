class CreatePricingZonals < ActiveRecord::Migration
  def change
    create_table :pricing_zonals do |t|
      t.integer :category_id
      t.integer :zonal_id
      t.string :category_name
      t.date :start_date
      t.date :end_date
      t.decimal :price

      t.timestamps null: false
    end
    add_index :pricing_zonals, [:category_id, :zonal_id]
  end
end
