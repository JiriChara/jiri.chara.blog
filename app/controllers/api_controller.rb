class ApiController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authenticate

  helper :api

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'Bad credentials' }, status: 401
  end

  rescue_from ActiveRecord::RecordNotFound, with: ->() {
    render_404
  }

  rescue_from ActionController::RoutingError, with: ->() {
    render_404
  }

  rescue_from ActionController::UnknownController, with: ->() {
    render_404
  }

  def current_user
    @current_user || authenticate
  end

protected
  def authenticate
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(auth_token: token)
    end
  end

  def render_404
    render json: { error: "Not found" }, status: 404
  end
end
