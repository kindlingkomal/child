class M::HomepageController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'mobile'

  def terms
  end

end
