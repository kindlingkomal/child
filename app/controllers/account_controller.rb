class AccountController < ApplicationController
  before_action :authenticate_user!
  
  def list
  	@user = current_user
  end
end