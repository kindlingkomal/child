class CategoriesController < ApplicationController
  layout 'customer'

  def index
    @categories = Category.all
  end
end
