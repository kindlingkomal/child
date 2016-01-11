class AddPickUpToRates < ActiveRecord::Migration
  def change
    add_reference :rates, :pick_up, index: true, foreign_key: true
  end
end
