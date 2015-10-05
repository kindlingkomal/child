class CreateZonals < ActiveRecord::Migration
  def change
    create_table :zonals do |t|
      t.string :zipcode
      t.float :lat
      t.float :lon
      t.string :address

      t.timestamps null: false
    end
  end
end
