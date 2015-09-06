class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.string :image

      t.timestamps null: false
    end
  end
end
