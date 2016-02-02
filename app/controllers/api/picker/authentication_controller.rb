class Api::Picker::AuthenticationController < Api::AuthenticationController

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

end
