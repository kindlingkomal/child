class Api::Common::PickUpsController < Api::ApiController
  def show
    @pick_up = PickUp.find_by(id: params[:id])
    render json: @pick_up
  end

end
