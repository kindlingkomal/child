class Api::Picker::AuthenticationController < Api::AuthenticationController

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
    unless user.ragpicker?
      render json: {error: {code: "20001", msg: "Phone number or password is incorrect"}}, status: 403 and return
    end
    user.last_sign_in_at = Time.now
    user.invalidate_authentication_token
    user.save

    render json: user, meta: { show_token: true }, serializer: UserDetailSerializer
  end

  def authenticated_user
    user = User.find_for_database_authentication(phone_number: format_phone_number)
    user if user && user.valid_password?(params[:password])
  end
end
