class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, if: :json_request? && :devise_controller?
  before_filter :authorize

  def json_request?
    request.format.json?
  end
  def current_user
    token = params[:token] || ""
    puts token
    if token.nil? || token.empty?
      #render json: {:status => false, :message => t('users.token.empty')}
      return nil
    else
      return User.where(oauth_token: token).first
    end
  end

  def authorize
  	puts "*"*200
  	@current_user =  current_user
    if @current_user.nil?
      render json: {:status => false, :message => t('users.token.invalid')}
    end
  end
end
