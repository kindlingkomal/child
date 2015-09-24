class Api::Common::UsersController < Api::ApiController
  def gcm_registration
    @current_user.update(gcm_registration: params[:gcm_registration])
    render json: {success: @current_user.errors.blank?, gcm_registration: @current_user.gcm_registration}
  end
end
