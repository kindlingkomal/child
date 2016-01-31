class CustomFailure < Devise::FailureApp
  def redirect_url
    request.original_url.index('/admin') ? super : root_url
  end
end
