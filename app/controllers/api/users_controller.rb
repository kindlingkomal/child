class Api::UsersController < Api::ApiController
  skip_before_action :authenticate_user_from_token!, only: [:create, :verify_otp]
  before_action :authenticate_user!, except: [:create, :verify_otp]

  def create
    @user = User.new user_params
    @user.inactive = true
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
      handle_errors_create
    end
  end

  def verify_otp
    otp = params[:otp].presence
    if otp && (@user = User.find_by(otp: otp)) && !@user.active?
      @user.activate_and_invalidate_authentication_token
      render json: {status: true, authentication_token: @user.authentication_token}
    else
      render json: {error: {code: 20009, msg: 'Your OTP is invalid'}}, status: 405
    end
  end

  def update
    @user = @current_user
    if @user.update(user_params)
      render json: @user
    else
      handle_errors_update
    end
  end

  def invite
    phone_number = params[:phone_number].presence
    name = params[:name].presence
    unless name && phone_number
      render json: {error: {code: 20010, msg: 'Name and phone number cannot be blank'}}, status: 405 and return
    end
    if User.where(phone_number: phone_number).count == 0
      @invitation = @current_user.invitations.
        create(phone_number: phone_number, name: name)
      render json: {success: true}
    else
      render json: {error: {code: 20011, msg: 'Phone number had already registered'}}, status: 405
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar,
      :full_name, :phone_number, :gender, :address, :city, :notified, :pincode, :lat, :lon)
  end

  def handle_errors_create
    code, msg =
      if User.find_by(phone_number: user_params[:phone_number])
        [10100, 'Request submitted for this phone number before']
      else
        [90002, @user.errors.full_messages.join('. ')]
      end
    render json: {error: {code: code, msg: msg}}, status: 405
  end

  def handle_errors_update
    code, msg =
      if User.where.not(id: @user.id).where(phone_number: user_params[:phone_number]).count > 0
        [10200, 'You are already registered']
      else
        [90002, @user.errors.full_messages.join('. ')]
      end
    render json: {error: {code: code, msg: msg}}, status: 405
  end
end
