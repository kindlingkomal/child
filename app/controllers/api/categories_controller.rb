class Api::CategoriesController < Api::ApiController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  def index
    term = params[:term].presence
    categories = Category.order(name: :asc)
    categories = categories.where("lower(name) like :q", q: "%#{term.downcase}%") if term
    render json:categories
  end
end
