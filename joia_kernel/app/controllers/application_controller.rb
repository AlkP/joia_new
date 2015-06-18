class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  def check_user
    if current_user.nil?
      redirect_to login_url
    else
      true
    end
  end
  helper_method :check_user
  def user?
    if current_user.nil?
      false
    else
      true
    end
  end
  helper_method :user?
  def check_admin
    if current_user.nil?
      redirect_to login_url
    else
      if ( current_user.admin != true )
        redirect_to login_url
      else
        true
      end
    end
  end
  helper_method :check_admin
  def admin?
    if current_user.nil?
      false
    else
      if ( current_user.admin != true )
        false
      else
        true
      end
    end
  end
  helper_method :admin?
  def usual_user?
    if current_user.nil?
      redirect_to login_url
    else
      if ( current_user.admin == true )
        redirect_to login_url
      else
        true
      end
    end
  end
  helper_method :usual_user?
end
