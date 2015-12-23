class AddTimeSlotToPickUps < ActiveRecord::Migration
  def change
    add_reference :pick_ups, :time_slot, index: true, foreign_key: true
  end
end
