class ProfileService < BaseService

  def update params
    user = current_user
    user_params = process_user_param(params)
    if !user_params[:current_password].blank? || !user_params[:password].blank?
      user.update_attributes(user_params)
    else
      user.update_attributes(user_params)
    end
    user
  end


private
  def process_user_param(params)
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation, :avatar,
      :full_name, :phone_number, :gender, :address, :city, :notified, :pincode, :lat, :lon)
  end

end
