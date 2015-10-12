class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_api_permission, :authenticate_user_from_token!
  before_action :authenticate_user!, except: :doc

  respond_to :json

  # rescue_from Exception do |ex|
  #   Rails.logger.error("\n\nEXCEPTION: #{ex.inspect}\n")
  #   render(json: {error: ex.message}, status: 500) and return
  # end

  rescue_from ActiveRecord::RecordNotFound do |e|
    missing_json = {
      errors: {
        msg: e.message
      }
    }
    Rails.logger.error("\n\nEXCEPTION: RecordNotFound #{e.inspect}\n")
    render(json: missing_json, status: 404) and return
  end




private

  def authenticate_user_from_token!
    auth_token = params[:token].presence
    user = User.find_by(authentication_token: auth_token) if auth_token
    # user       = auth_token && User.where(:authentication_token => auth_token.to_s).first

    if user && user.active?
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
      @current_user = user

      # if request.url.include?('/api/ragpicker/')
      #   unless @current_user.ragpicker?
      #     @current_user = nil
      #     render json: {error: {code: "20001", msg: "role invalid"}}, status: 403
      #   end
      # elsif request.url.include?('/api/common/')
      #   if @current_user.admin?
      #     @current_user = nil
      #     render json: {error: {code: "20001", msg: "role invalid"}}, status: 403
      #   end
      # else
      #   unless @current_user.user?
      #     @current_user = nil
      #     render json: {error: {code: "20001", msg: "role invalid"}}, status: 403
      #   end
      # end
    else
      render json: {error: {code: "20000", msg: "token invalid"}}, status: 403
    end
  end


  def authorize_api_permission
    if request.headers['x-svalue-auth'] != '1234512345'
      render(json: {
        error: {
          code: 4000,
          msg: "x-svalue-auth is invalid"
        }
      }, status: 401) and return
    end
  end

end
