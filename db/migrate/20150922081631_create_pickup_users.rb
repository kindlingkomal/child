class CreatePickupUsers < ActiveRecord::Migration
  def change
    create_table :pickup_users do |t|
      t.references :pick_up, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :type
      t.string :reason
      t.datetime :canceled_at
      t.datetime :rejected_at
      t.datetime :accepted_at

      t.timestamps null: false
    end
  end
end
