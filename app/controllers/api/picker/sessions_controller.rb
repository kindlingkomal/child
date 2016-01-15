class Api::Picker::SessionsController < Api::PickerController
  skip_before_action :authenticate_user_from_token!, :require_picker!, only: [:create, :verify_otp]
  before_action :authenticate_user!, except: [:create, :verify_otp]

  def create
    @user = User.new user_params
    @user.inactive = true
    @user.role = :ragpicker
    if @user.save
      if (@invitation = Invitation.find_by(phone_number: @user.phone_number))
        @invitation.update(user: @user, accepted_at: @user.created_at)
      end
      raw = NumberTokenGenerator.instance.generate_unique_code(User, :otp)
      @user.update(otp: raw)
      SmsService.send_otp @user.phone_number, @user.otp
      render json: @user, meta: {
        otp: @user.otp
      }
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

  #def signin
  #  user = User.ragpickers.find_for_database_authentication(
  #    phone_number: params[:phone_number].try(:downcase)
  #  )
  #  if user && user.valid_password?(params[:password])
  #    user.last_sign_in_at = Time.now
  #    user.invalidate_authentication_token
  #    user.save
  #    render json: user, serializer: UserDetailSerializer
  #  else
  #    user = User.find_for_database_authentication(
  #      phone_number: params[:phone_number].try(:downcase)
  #    )
  #    if user.nil?
  #      render json: {error: {code: 10000, msg: "User not registered"}}, status: 403
  #    elsif !user.valid_password?(params[:password])
  #      render json: {error: {code: 10001, msg: "Invalid password"}}, status: 403
  #    else
  #      render json: {error: {code: 90000, msg: "Bad credentials"}}, status: 403
  #    end
  #  end
  #end

  def verify_otp
    otp = params[:otp].presence
    if otp && (@user = User.find_by(otp: otp)) && !@user.active?
      @user.activate_and_invalidate_authentication_token
      render json: {status: true, authentication_token: @user.authentication_token}
    else
      render json: {error: {code: 20009, msg: 'Your OTP is invalid'}}, status: 405
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar,
      :full_name, :phone_number, :gender, :address, :city, :notified, :pincode,
      :lat, :lon, :yard_number)
  end

end
