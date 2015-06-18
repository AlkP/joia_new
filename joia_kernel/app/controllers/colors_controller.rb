class ColorsController < ApplicationController
  before_filter :check_admin
  def index
    @colors = Color.all
    @color = Color.new
  end
  def create
    Color.create(name: params[:color][:name])
    redirect_to(colors_path)
  end
  def destroy
    Color.find(params[:id]).destroy
    redirect_to(colors_path)
  end
end
