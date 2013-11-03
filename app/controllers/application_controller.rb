class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message

    redirect_to oops_path(status: 303)
  end
end
