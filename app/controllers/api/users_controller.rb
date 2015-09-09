class Api::UsersController < Api::ApiController
  skip_before_action :authenticate_user_from_token!, only: [:create]
  before_action :authenticate_user!, except: [:create]

  def create
    @user = User.new user_params
    # @user.inactive = true
    if @user.save
      render json: @user
    else
      handle_errors_create
    end
  end

  def update
    @user = @current_user
    if @user.update(user_params)
      render json: @user
    else
      handle_errors_update
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar,
      :full_name, :phone_number, :gender, :address, :city, :notified, :pincode, :lat, :lon)
  end

  def handle_errors_create
    code, msg =
      if User.find_by(phone_number: user_params[:phone_number])
        [10100, 'Request submitted for this phone number before']
      else
        [90002, @user.errors.full_messages.join('. ')]
      end
    render json: {error: {code: code, msg: msg}}, status: 405
  end

  def handle_errors_update
    code, msg =
      if User.where.not(id: @user.id).where(phone_number: user_params[:phone_number]).count > 0
        [10200, 'You are already registered']
      else
        [90002, @user.errors.full_messages.join('. ')]
      end
    render json: {error: {code: code, msg: msg}}, status: 405
  end
end
