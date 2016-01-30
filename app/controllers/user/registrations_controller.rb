class User::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.inactive = true
    resource.save
    if resource.persisted?
      flash[:notice] = "Welcome! You have signed up successfully."
      raw = NumberTokenGenerator.instance.generate_unique_code(User, :otp)
      resource.update(otp: raw)
      SmsService.send_otp resource.phone_number, resource.otp
    else
      clean_up_passwords resource
      set_minimum_password_length
    end
  end
  private

  def sign_up_params
    params.require(:user).permit(:full_name, :phone_number, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:full_name, :phone_number, :email, :password, :password_confirmation, :current_password)
  end
end
