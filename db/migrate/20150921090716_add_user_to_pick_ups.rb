class AddUserToPickUps < ActiveRecord::Migration
  def change
    add_reference :pick_ups, :user, index: true, foreign_key: true
  end
end
