class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  http_basic_authenticate_with name: "Joia_project", password: "Joia"

  $name = "Главное наименование"

  # protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

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

  def check_user
    if current_user.nil?
      redirect_to login_url
    else
      true
    end
  end
  helper_method :check_user

end
