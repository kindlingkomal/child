class Api::CategoriesController < Api::ApiController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  def index
    render json: Category.order(name: :asc)
  end
end
