class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :invited_by, index: true
      t.string :name
      t.string :phone_number
      t.datetime :accepted_at

      t.timestamps null: false
    end
    add_foreign_key :invitations, :users, column: :invited_by_id
  end
end
