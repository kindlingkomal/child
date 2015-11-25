class Users::SessionsController < Devise::SessionsController
  def create
    redirect_to root_path if !request.xhr?
    user_params = params[:user]
    @user = User.find_by_phone_number(user_params[:phone_number])
    if @user && @user.valid_password?(user_params[:password])
      flash[:notice] = "Login successfully."
      sign_in(:user, @user)
      render :js => "window.location = 'account'"
    end
  end
end