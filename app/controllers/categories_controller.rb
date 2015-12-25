class CategoriesController < ApplicationController
  layout 'customer'

  def index
  	@user = current_user
    @categories = Category.all
  end
end
