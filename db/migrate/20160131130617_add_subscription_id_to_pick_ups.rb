class AddSubscriptionIdToPickUps < ActiveRecord::Migration
  def change
    add_reference :pick_ups, :subscription, index: true, foreign_key: true
  end
end
