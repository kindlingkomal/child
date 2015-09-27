class Api::Ragpicker::CustomersController < Api::ApiController

  def create
    @customer = Customer.new customer_params
    if @customer.save
      render json: @customer
    else
      handle_errors_create
    end
  end

private
  def customer_params
    params.require(:customer).permit(:name, :phone_number)
  end

  def handle_errors_create
    code, msg = [90002, @customer.errors.full_messages.join('. ')]
    render json: {error: {code: code, msg: msg}}, status: 405
  end

end
