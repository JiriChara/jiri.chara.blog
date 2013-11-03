module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user
    @current_user ||= if cookies[:remember_token]
      User.find_by(remember_token: cookies[:remember_token])
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def store_location
    session[:return_to] = {
      method: request.method,
      url:    request.url,
      params: params
    }
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:warning] = "Please sign in first."
      respond_to do |format|
        format.html { redirect_to signin_url }
        format.js { render js: "window.location.href = '#{signin_path}';" }
      end
    end
  end
end
