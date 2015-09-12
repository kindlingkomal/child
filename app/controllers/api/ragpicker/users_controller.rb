class Api::Ragpicker::UsersController < Api::UsersController

  def create
    super
    @user.ragpicker!
  end

end
