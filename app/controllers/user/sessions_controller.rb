class User::SessionsController < Devise::SessionsController

  def create
    redirect_to root_path if !request.xhr?
    user_params = params[:user]
    @user = User.find_by_phone_number(user_params[:phone_number])
    if @user && !@user.active?
      if @user.otp == user_params[:otp]
        @user.activate_and_invalidate_authentication_token
      else
        sign_out
      end
    end
    if @user && @user.active? && @user.user? && @user.valid_password?(user_params[:password])
      flash[:notice] = "Login successfully."
      sign_in(:user, @user)
      path = params[:after_signin_path].presence
      render :js => "window.location = '#{path ? path : user_categories_url}'"
    end
  end
end
