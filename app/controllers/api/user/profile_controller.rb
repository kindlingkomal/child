class Api::User::ProfileController < Api::UserController
  before_action :init_service

  # def device
  #   @mobile = MobileDevice.where(token: device_params[:token], platform: device_params[:platform]).first
  #   @mobile ||= current_user.mobile_devices.new(device_params)
  #   @mobile.owner = current_user
  #   @mobile.enabled = true
  #   if @mobile.save
  #     render json: {message: 'Register user device successfully.'}, status: 200
  #     return
  #   else
  #     render json: @mobile.errors, status: 406
  #     return
  #   end
  # end

  def show
    @user = current_user
    render json: @user
  end

  def update
    @result = @service.update(params)
    if @result.errors.any?
      render json: {error: {code: 4000, message: @result.errors.full_messages.join(', ')}}, status: 405
    else
      render json: {success: true}
    end
  end

private

  def init_service
    @service = ProfileService.new(current_user)
  end

end
