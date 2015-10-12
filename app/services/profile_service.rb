class ProfileService < BaseService

  def update params
    user = current_user
    user_params = process_user_param(params)
    user.update_attributes(user_params)
    user
  end


private
  def process_user_param(params)
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation, :avatar,
      :full_name, :phone_number, :gender, :address, :city, :notified, :pincode, :lat, :lon)
  end

end
