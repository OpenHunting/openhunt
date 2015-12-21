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

  helper_method :current_subscriber
  def current_subscriber
    @__current_subcriber ||= begin
      current_user.try(:list_subscriber) || (session[:subscriber_id].present? ? ListSubscriber.where(id: session[:subscriber_id]).first : nil)
    end
  end

  def set_subscriber(list_subscriber)
    session[:subscriber_id] = list_subscriber.try(:id)

    associate_subscriber

    list_subscriber
  end

  def clear_subscriber
    session[:subscriber_id] = nil
  end

  def set_user(user)
    session[:user_id] = user.try(:id)

    associate_subscriber

    current_user
  end

  def clear_user
    session[:user_id] = nil
  end

  def associate_subscriber
    if current_user.present? and current_subscriber.present?
      current_user.set_subscriber(current_subscriber)
    end
  end

  helper_method :anon_user_hash
  def anon_user_hash
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

  helper_method :moderator?
  def moderator?
    current_user.try(:moderator?)
  end

  helper_method :show_intro?
  def show_intro?
    # current_user.blank? and !session[:intro_shown]
    return false
  end

  after_filter :mark_intro_shown
  def mark_intro_shown
    session[:intro_shown] = true
  end
end
