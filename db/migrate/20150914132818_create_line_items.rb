class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :category, index: true, foreign_key: true
      t.references :pick_up, index: true, foreign_key: true
      t.integer :quantity
      t.decimal :cost_price, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
