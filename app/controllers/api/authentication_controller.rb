class Api::AuthenticationController < Api::ApiController
  skip_before_action :authenticate_user!, only: :create

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
      render json: {success: true}
    else
      render json: {success: false, error: {code: "S_404_1", msg: "user not found"}}, status: 403
    end
  end

protected
  def login_user(user)
    user.last_sign_in_at = Time.now
    user.invalidate_authentication_token
    user.save

    render json: user, meta: { show_token: true }
  end

  def authenticated_user
    user = User.find_for_database_authentication(
      phone_number: params[:phone_number].try(:downcase)
    )
    user if user && user.valid_password?(params[:password])
  end

  def cannot_log_in
    user = User.find_for_database_authentication(
      phone_number: params[:phone_number].try(:downcase)
    )
    if user.nil?
      render json: {error: {code: "10000", msg: "User not registered"}}, status: 403
    elsif not user.valid_password?(params[:password])
      render json: {error: {code: "10001", msg: "Invalid password"}}, status: 403
    else
      render json: {error: {code: "S_401_1", msg: "Bad credentials"}}, status: 403
    end
  end

  def not_active
    render json: {error: {msg: "Your account is not activated yet."}}, status: 403
  end
end
