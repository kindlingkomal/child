class Api::Picker::RatesController < Api::PickerController

  def create
    dimension = 'customer'
    @user = User.find_by(id: params[:user_id])
    if @user.nil?
      render json: {error: {code: 20001, msg: "User not registered"}}, status: 405
    elsif @user.rate(params[:score].to_f, @current_user, dimension)
      @current_rate = @user.reload.rates(dimension).where(rater_id: @current_user.id).take
      @current_rate.update(comment: params[:comment])
      render json: {success: true}
    else
      render json: {error: {code: 20000, msg: "Rating failed"}}, status: 405
    end

  end
end
