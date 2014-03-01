class SessionsController < ApplicationController
  authorize_resource class: false

  # # Google is reseting session otherwise..
  skip_before_filter :verify_authenticity_token, only: [:create]

  def new
  end

  def create
    auth = request.env['omniauth.auth'] || request.env['rack.auth'] || request['auth']
    user = User.from_omniauth(auth)
    sign_in(user)
    flash[:success] = "Successfully signed in."

    Rails.logger.info "Session: #{session.inspect}"

    if session[:return_to].blank? ||
       session[:return_to][:expires_in] < Time.zone.now
      redirect_to root_path
    end
  end

  def failure
    flash[:notice] = params[:message]
    redirect_to root_path
  end

  def destroy
    sign_out
    flash[:success] = "Successfully signed out."
    redirect_to(root_url)
  end
end
