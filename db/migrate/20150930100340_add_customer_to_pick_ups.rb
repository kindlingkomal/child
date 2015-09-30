class AddCustomerToPickUps < ActiveRecord::Migration
  def change
    add_reference :pick_ups, :customer, index: true, foreign_key: true
  end
end
