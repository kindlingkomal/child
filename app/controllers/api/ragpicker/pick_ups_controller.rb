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
    @pick_ups = @pick_ups.where(parent_id: nil)
    if params[:date].present? && (date = Util.beginning_of_day params[:date] rescue nil)
      @pick_ups = @pick_ups.where(':start <= start_time AND start_time < :end',
        start: date, end: date + 1.day)
    end
    @total_pick_ups = @pick_ups.count
    @pick_ups = @pick_ups.order(created_at: :desc)
    @pick_ups = @pick_ups.page(params[:page]).per(params[:per_page] || 10)
    render json: @pick_ups,
      meta: {
        current_user_id: @current_user.id,
        total_pages: @pick_ups.total_pages, total_pick_ups: @total_pick_ups
      }
  end

end
