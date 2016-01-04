class CategoriesController < ApplicationController
  layout 'customer'

  def index
    @categories = Category.order(:status, :name)
    @selected_category_ids = session[:selected_category_ids] || []
  end
end
