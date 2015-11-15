class CreateNotifyingPickups < ActiveRecord::Migration
  def change
    create_table :notifying_pickups do |t|
      t.references :pick_up, index: true, foreign_key: true
      t.references :ragpicker, index: true
      t.datetime :sent_at

      t.timestamps null: false
    end
    add_foreign_key :notifying_pickups, :users, column: :ragpicker_id
  end
end
