class Api::AuthenticationController < Api::ApiController
  skip_before_action :authenticate_user_from_token!, only: [:create, :resendpwd]
  skip_before_action :authenticate_user!, only: [:create, :resendpwd]

  def create
    if user = authenticated_user
      if user.active?
        login_user(user)
      else
        not_active
      end
    else
      cannot_log_in
    end
  end

  def logout
    if @current_user
      @current_user.invalidate_authentication_token!
      @current_user.update(gcm_registration: nil)
      render json: {success: true}
    end
  end

  def resendpwd
    user = User.find_by({
      phone_number: format_phone_number
    })
    if user
      password = Time.now.to_i.to_s(16)
      # user.password = '1234512345'
      user.password = password
      if user.save && SmsService.send_reset_pwd(user.phone_number, password)
        render json: {success: true}
      else
        render json: {error: {code: 10001, msg: "Could not send password to your number"}}, status: 403
      end
    else
      render json: {error: {code: 10000, msg: "User not registered"}}, status: 403
    end
  end

protected
  def login_user(user)
    unless user.user?
      render json: {error: {code: "20001", msg: "Phone number or password is incorrect"}}, status: 403 and return
    end
    user.last_sign_in_at = Time.now
    user.invalidate_authentication_token
    user.save

    render json: user, meta: { show_token: true }
  end

  def authenticated_user
    user = User.find_for_database_authentication(phone_number: format_phone_number)
    user if user && user.valid_password?(params[:password])
  end

  def cannot_log_in
    user = User.find_for_database_authentication(
      phone_number: params[:phone_number].try(:downcase)
    )
    if user.nil?
      render json: {error: {code: 10000, msg: "User not registered"}}, status: 403
    elsif not user.valid_password?(params[:password])
      render json: {error: {code: 10001, msg: "Invalid password"}}, status: 403
    else
      render json: {error: {code: 90000, msg: "Bad credentials"}}, status: 403
    end
  end

  def not_active
    render json: {error: {code: 90001, msg: "Your account is not activated yet."}}, status: 403
  end

  def format_phone_number
    phone_number = params[:phone_number].try(:downcase)
    phone_number = "+#{phone_number}" if phone_number.index('91') == 0
    phone_number = "+91#{phone_number}" if phone_number.index("+91") != 0
    phone_number
  end
end
