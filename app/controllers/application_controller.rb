class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  check_authorization

  before_filter :get_access_info
  around_filter :user_time_zone

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message

    session[:error_code] = 303

    redirect_to oops_path
  end

  def get_access_info
    info = AccessInfo.find_or_create_by(
      ip: request.remote_ip,
      browser: browser.name,
      version: browser.version,
      platform: browser.platform
    )

    if signed_in? && !current_user.access_infos.include?(info)
      current_user.access_infos << info
    end
  end

  def user_time_zone(&block)
    authorize!(:user_time_zone, :application)

    begin
      if current_user && current_user.time_zone.present?
        Time.use_zone(current_user.time_zone, &block)
      else min = request.cookies["time_zone"].to_i
        time_zone = ActiveSupport::TimeZone[-min.minutes]

        if signed_in?
          current_user.time_zone = time_zone.name; current_user.save
        end

        Time.use_zone(time_zone, &block)
      end
    rescue
      yield
    end
  end
end
