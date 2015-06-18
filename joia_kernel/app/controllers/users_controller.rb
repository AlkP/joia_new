class UsersController < ApplicationController
  before_filter :check_admin, except: [:update, :change_password]
  before_filter :check_user
  def index
    @users = User.all
  end
  def new
    @user = User.new
    @type = Type.all
  end
  def update
    if current_user.admin?
      user = User.find(params[:id])
      if params[:users][:admin_select] == "0"
        user.update(admin: true, type_id: nil)
      else
        user.update(admin: false, type_id: params[:users][:type_select])
      end
    else
      user = User.find(current_user.id)
    end
    if user.update(users_params)
      current_user.admin? ? (redirect_to users_path) : (redirect_to root_path)
    else
      current_user.admin? ? (render 'show') : (redirect_to root_path)
    end
  end
  def show
    @user = User.find(params[:id])
    @type = Type.all
  end
  def change_password
    @user = User.find(current_user.id)
  end
  def create
    @user = User.new(users_params)
    if params[:users][:admin_select] == "0"
      @user.update(admin: true, type_id: nil)
    else
      @user.update(admin: false, type_id: params[:users][:type_select])
    end
    if @user.save
      redirect_to root_url, notice: "You are sign up !"
    else
      render "new"
    end
  end
  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end
  private
  def users_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation)
  end
end
