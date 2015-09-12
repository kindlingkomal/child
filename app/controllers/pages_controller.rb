class PagesController < ApplicationController
  def doc
  end

  def ragpicker
    render 'pages/ragpicker/ragpicker'
  end
end
