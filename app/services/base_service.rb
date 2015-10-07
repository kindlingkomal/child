class BaseService
  def initialize user
    @current_user = user
  end

  def current_user
    @current_user
  end
end
