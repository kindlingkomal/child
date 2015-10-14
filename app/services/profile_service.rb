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

# curl --header 'x-svalue-auth:1234512345' -X POST http://localhost:3000/api/picker/pick_ups -d 'token=HVfxjqLSgb6wRpuFGQRH&pick_up[start_time]=1444546157&pick_up[end_time]=1444563469&customer[phone_number]=3213456122&customer[name]=oh here&line_items[][category_id]=1&line_items[][quantity]=20&line_items[][category_id]=2&line_items[][quantity]=10'
