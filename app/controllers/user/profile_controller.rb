class User::ProfileController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    @user.update_with_password(user_params)

    if @user.errors.blank?
      flash[:notice] = "Updated your profile successfully."
      sign_in @user, bypass: true
      redirect_to user_profile_path
    else
      render :edit
    end
  end

  private
  def get_user
  	@user = current_user
  end

  def user_params
    params.require(:user).permit(:full_name, :phone_number, :email, :address, :avatar,
      :current_password, :password, :password_confirmation, :gender)
  end
end
