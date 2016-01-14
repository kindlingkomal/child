class Api::User::RatesController < Api::UserController

  def create
    dimension = 'ragpicker'
    @user = User.find(params[:user_id])
    pick_up_id = params[:pick_up_id].presence
    pickup = PickUp.find_by(id: pick_up_id)
    render json: {error: {code: 20001, msg: "This order was rated."}}, status: 405 and return if pickup.has_ratings
    if pickup && pickup.status? && pickup.status != 'pending' &&
    @user.rate_for_pickup(pick_up_id, params[:score].to_f, @current_user, dimension)
      @current_rate = @user.reload.rates(dimension).where(rater_id: @current_user.id).
        where(pick_up_id: pick_up_id).take
      @current_rate.update(comment: params[:comment])
      pickup.update(has_ratings: true)
      render json: {success: true}
    else
      render json: {error: {code: 20000, msg: "Rating failed"}}, status: 405
    end

  end
end
