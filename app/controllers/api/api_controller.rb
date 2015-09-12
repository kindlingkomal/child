class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!, except: :doc

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do |e|
    missing_json = {
      errors: {
        msg: e.message
      }
    }
    render json: missing_json, status: 404
  end

private

  def authenticate_user_from_token!
    auth_token = params[:token].presence
    user       = auth_token && User.where(:authentication_token => auth_token.to_s).first

    if user && user.active?
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
      if user.active?
        @current_user = user
        if request.url.include?('/api/ragpicker/')
          unless @current_user.ragpicker?
            @current_user = nil
            render json: {error: {code: "20001", msg: "role invalid"}}, status: 403
          end
        else
          unless @current_user.user?
            @current_user = nil
            render json: {error: {code: "20001", msg: "role invalid"}}, status: 403
          end
        end
      end
    else
      render json: {error: {code: "20000", msg: "token invalid"}}, status: 403
    end
  end

end
