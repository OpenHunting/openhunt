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

end
