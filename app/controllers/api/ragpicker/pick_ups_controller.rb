class Api::Ragpicker::PickUpsController < Api::ApiController
  def index
    @pick_ups = case params[:filter]
    when 'accepted'
      PickUp.accepted
    when 'pending'
      PickUp.pending
    else
      PickUp.where(id: -1)
    end
    render json: @pick_ups.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 10),
      meta: { current_user_id: @current_user.id }
  end

end
