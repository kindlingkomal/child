class Api::Common::PickUpsController < Api::ApiController
  def show
    @pick_up = PickUp.find_by(id: params[:id])
    render json: @pick_up
  end

  def index
    case params[:filter]
    when 'done'
      @pick_ups = PickUp.accepted.joins(:accepted_users).where.not(proceeded_at: nil).uniq
    when 'accepted'
      @pick_ups = PickUp.accepted.joins(:accepted_users).uniq
    when 'pending'
      @pick_ups = PickUp.pending
    when 'canceled'
      @pick_ups = PickUp.joins(:accepted_users).where.not(pickup_users: {canceled_at: nil}).uniq
    when 'canceled_tab'
      query = PickupUser[:canceled_at].not_eq(nil).or(PickupUser[:rejected_at].not_eq(nil))
      @pick_ups = PickUp.joins(:pickup_users).where(query).uniq
    else
      @pick_ups = PickUp.where.not(id: -1)
    end

    if %w(done accepted canceled canceled_tab).include?(params[:filter])
      if (ragpicker_id = params[:ragpicker_id]).present?
        @pick_ups = @pick_ups.where(pickup_users: {user_id: ragpicker_id})
      end
    end

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
