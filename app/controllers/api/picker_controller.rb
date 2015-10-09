class Api::PickerController < Api::ApiController
  before_action :require_picker!


protected
  def require_picker!
    if !current_user || !current_user.ragpicker?
      render json: {error: {msg: 'Invalid action', code: 403}}, status: 403
    end
  end

end
