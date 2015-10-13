class CreateCategoriesPickups < ActiveRecord::Migration
  def change
    create_table :categories_pick_ups, :id => false do |t|
      t.integer :category_id
      t.integer :pick_up_id
    end
    add_index :categories_pick_ups, :category_id
    add_index :categories_pick_ups, :pick_up_id
  end
end
