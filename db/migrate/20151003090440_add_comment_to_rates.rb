class AddCommentToRates < ActiveRecord::Migration
  def change
    add_column :rates, :comment, :text
  end
end
