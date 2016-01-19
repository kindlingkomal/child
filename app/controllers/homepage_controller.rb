class HomepageController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if Category.where(status: 1).count > 0 # featured categories
      @categories = Category.where(status: 1).order(position: :asc)
    else
      @categories = Category.take(5)
    end
  end

  def about
  end

  def terms
  end

  def become_partner
    render 'become_partner', layout: 'picker'
  end
end
