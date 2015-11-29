class CategoriesController < ApplicationController
  def index
  	@user = current_user
    @categories = Category.all	
  end
end