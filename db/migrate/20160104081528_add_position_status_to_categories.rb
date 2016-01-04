class AddPositionStatusToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :position, :integer
    add_column :categories, :status, :integer
  end
end
