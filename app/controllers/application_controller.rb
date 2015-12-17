class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  # put the common properties that get added to all react_page renders
  helper_method :react_common
  def react_common
    {
      current_user: current_user,
      params: params
    }
  end

  helper_method :current_user
  def current_user
    @__current_user ||= begin
      session[:user_id].present? ? User.where(id: session[:user_id]).first : nil
    end
  end

  def login_user(user)
    session[:user_id] = user.try(:id)
  end

  def logout_user
    session[:user_id] = nil
  end

  helper_method :current_session
  def current_session
    session[:session_id] ||= begin
      new_session_id = SecureRandom.base64(15).tr('+/=lIO0-', 'pqrsxyzb')
      session[:session_id] = new_session_id
      new_session_id
    end
  end

  def require_user
    if current_user.present?
      return true
    else
      redirect_to "/login?redirect_to=#{request.path}"
      return false
    end
  end

  helper_method :current_now
  def current_now
    Time.find_zone!(Settings.base_timezone).now
  end

end
