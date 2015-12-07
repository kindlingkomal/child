class AddPaymentMethodToPickUps < ActiveRecord::Migration
  def change
    add_column :pick_ups, :payment_method, :string, default: 'COP'
  end
end
