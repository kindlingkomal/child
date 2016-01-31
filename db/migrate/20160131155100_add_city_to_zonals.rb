class AddCityToZonals < ActiveRecord::Migration
  def change
    add_column :zonals, :city, :string
  end
end
