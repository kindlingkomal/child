class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :start_hour, null: false
      t.integer :end_hour, null: false
      t.boolean :inactive, default: false

      t.timestamps null: false
    end
  end
end
