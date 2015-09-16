class Api::TimeSlotsController < Api::ApiController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  def index
    render json: TimeSlot.where(inactive: false)
  end
end
