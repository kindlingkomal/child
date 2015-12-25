class Picker::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.role = :ragpicker
    resource.save
    if resource.persisted?
      if resource.active_for_authentication?
        flash[:notice] = "Welcome! You have signed up successfully."
        sign_up(resource_name, resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
    end
  end

private

  def resource_name
    :user
  end

  def sign_up_params
    params.require(:user).permit(:full_name, :phone_number, :email, :password, :password_confirmation, :pincode, :address)
  end

  def account_update_params
    params.require(:user).permit(:full_name, :phone_number, :email, :password, :password_confirmation, :current_password)
  end
end
