class AccountController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only: [:list, :setting]		  
  def list
  end

  def setting
  end

  private 
  def get_user
  	@user = current_user
  end
end