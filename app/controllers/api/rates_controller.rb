class Api::RatesController < Api::ApiController

  def create
    dimension = 'ragpicker'
    @user = User.find_by(id: params[:user_id])
    if @user.ragpicker? && @user.rate(params[:score].to_f, @current_user, dimension)
      @current_rate = @user.reload.rates(dimension).where(rater_id: @current_user.id).take
      @current_rate.update(comment: params[:comment])
      render json: @current_rate
    else
      render json: {error: {code: 20000, msg: "Rating failed"}}, status: 405
    end

  end
end
