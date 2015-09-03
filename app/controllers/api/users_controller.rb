class Api::UsersController < Api::ApiController
  skip_before_action :authenticate_user_from_token!, only: [:create]
  before_action :authenticate_user!, except: [:create]

  def create
    @user = User.new user_params
    # @user.inactive = true
    if @user.save && @user.errors.blank?
      render json: @user
    else
      handle_errors_create
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
      :full_name, :phone_number, :avatar)
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

end
