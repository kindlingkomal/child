class AccountController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only: [:ratecard, :profile, :edit, :update]		  

  def update
    if !user_params[:current_password].blank? && !user_params[:password].blank?
      @user.update_with_password(user_params)    
    else
      user_param_dup = user_params.dup
      user_param_dup.delete(:current_password)
      user_param_dup.delete(:password)
      user_param_dup.delete(:password_confirmation)
      @user.update_attributes(user_param_dup)
    end

    if @user.errors.blank?
      flash[:notice] = "Updated your profile successfully."
      sign_in @user, bypass: true
      redirect_to account_profile_path
    else
      render :edit
    end
  end

  private 
  def get_user
  	@user = current_user
  end

  def user_params
    params.require(:user).permit(:full_name, :phone_number, :email, :address, :current_password, :password, :password_confirmation, :gender)    
  end
end