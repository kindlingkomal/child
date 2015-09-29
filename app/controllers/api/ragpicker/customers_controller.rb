class Api::Ragpicker::CustomersController < Api::ApiController

  def add_customers
    customers = []
    params[:customers].each do |cus|
      customer = Customer.find_or_create_by name: cus[:name], phone_number: cus[:phone_number]
      customers << customer if customer.errors.blank?
    end
    render json: customers
  end

end
