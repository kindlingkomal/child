class PagesController < ApplicationController
  layout "api"

  def doc
  end

  def ragpicker
    render 'pages/ragpicker/ragpicker'
  end

end
