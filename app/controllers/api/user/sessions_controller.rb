class Api::User::SessionsController < Api::UserController
  skip_before_action :authenticate_user_from_token!, only: [:create, :resetpwd]
  before_action :authenticate_user!, except: [:create, :resetpwd]

  def resetpwd
  end

end
