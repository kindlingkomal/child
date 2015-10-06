class Api::User::PickUpsController < Api::ApiController

  def show
    @pick_up = PickUp.where(user_id: current_user.id).find params[:id]
    render json: @pick_up
  end

  def index
    @pick_ups = PickUp.where(user_id: current_user.id)
    @pick_ups = @pick_ups.page(params[:page]).per(params[:per_page] || 10)
  end

  def pending
    @pick_ups = PickUp.pending.where(user_id: current_user.id)
    @pick_ups = @pick_ups.page(params[:page]).per(params[:per_page] || 10)
  end

  def done
    @pick_ups = PickUp.accepted.joins(:accepted_users).where.not(proceeded_at: nil).uniq
  end

  def accepted
    @pick_ups = PickUp.accepted.joins(:accepted_users).uniq
  end

  def canceled
    @pick_ups = PickUp.joins(:accepted_users).where.not(pickup_users: {canceled_at: nil}).uniq
  end



end
