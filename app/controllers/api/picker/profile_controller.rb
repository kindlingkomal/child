class Api::Picker::ProfileController < Api::PickerController
  before_action :init_service

  def show
    @user = current_user
    render json: @user, serializer: UserDetailSerializer
  end

  def update
    @result = @service.update(params)
    if @result.errors.any?
      render json: {error: {code: 4000, msg: @result.errors.full_messages.join(', ')}}, status: 405
    else
      render json: {success: true}
    end
  end

  def device
    @user = current_user
    @user.gcm_registration = params[:device_token]
    if @user.save
      render json: {error: {code: 4000, msg: @user.errors.full_messages.join(', ')}}, status: 405
    else
      render json: {success: true}
    end
  end

private

  def init_service
    @service = ProfileService.new(current_user)
  end

end
