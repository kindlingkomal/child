class CreateCategoriesPickups < ActiveRecord::Migration
  def change
    create_table :categories_pickups, :id => false do |t|
      t.integer :category_id
      t.integer :pick_up_id
    end
    add_index :categories_pickups, :category_id
    add_index :categories_pickups, :pick_up_id
  end
end
