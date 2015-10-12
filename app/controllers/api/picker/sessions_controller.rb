class Api::Picker::SessionsController < Api::PickerController
  skip_before_action :authenticate_user_from_token!, :require_picker!, only: [:create]
  before_action :authenticate_user!, except: [:create]

  def create
    @user = User.new user_params
    # @user.inactive = true
    @user.role = :ragpicker
    if @user.save
      if (@invitation = Invitation.find_by(phone_number: @user.phone_number))
        @invitation.update(user: @user, accepted_at: @user.created_at)
      end
      render json: @user
    else
      code, msg =
        if User.find_by(phone_number: user_params[:phone_number])
          [10100, 'Request submitted for this phone number before']
        else
          [90002, @user.errors.full_messages.join('. ')]
        end
      render json: {error: {code: code, msg: msg}}, status: 405
    end
  end


  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :avatar,
        :full_name, :phone_number, :gender, :address, :city, :notified, :pincode, :lat, :lon)
    end

end
