class Api::Common::PickUpsController < Api::ApiController
  def show
    @pick_up = PickUp.find_by(id: params[:id])
    render json: @pick_up
  end

  def index
    @pick_ups = case params[:filter]
    when 'accepted'
      PickUp.accepted
    when 'pending'
      PickUp.pending
    else
      PickUp.where.not(id: -1)
    end
    @pick_ups = @pick_ups.where(parent_id: nil)
    if (user_id = params[:user_id]).present?
      @pick_ups = @pick_ups.where(user_id: user_id)
    end
    if params[:date].present? && (date = Util.beginning_of_day params[:date] rescue nil)
      @pick_ups = @pick_ups.where(':start <= start_time AND start_time < :end',
        start: date, end: date + 1.day)
    end
    @pick_ups = @pick_ups.order(created_at: :desc)
    @pick_ups = @pick_ups.page(params[:page]).per(params[:per_page] || 10)
    render json: @pick_ups,
      meta: {
        current_user_id: @current_user.id,
        total_pages: @pick_ups.total_pages, total_pick_ups: @pick_ups.total_count
      }
  end
end
