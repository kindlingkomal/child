class Api::UserController < Api::ApiController


  def require_user!
    if !current_user || !current_user.user?
      render json: {error: {msg: 'Invalid action', code: 403}}, status: 403
    end
  end
end
