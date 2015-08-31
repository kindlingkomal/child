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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def handle_errors_create
    code, msg =
      if User.find_by(email: user_params[:email])
        [10101, 'Request submitted for this email address before']
      else
        ["U_405_2", @user.errors.full_messages]
      end
    render json: {error: {code: code, msg: msg}}, status: 405
  end

end
