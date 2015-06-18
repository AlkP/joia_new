class SugarsController < ApplicationController
  before_filter :check_admin
  def index
    @sugars = Sugar.all
  end
  def new
    @sugar = Sugar.new
  end
  def create
    Sugar.create(sugar_params)
    redirect_to(sugars_path)
  end
  def update
    Sugar.find(params[:id]).update(sugar_params)
    redirect_to(sugars_path)
  end
  def show
    @sugar = Sugar.find(params[:id])
  end
  def destroy
    Sugar.find(params[:id]).destroy
    redirect_to(sugars_path)
  end
  private
  def sugar_params
    params.require(:sugar).permit( :name, :name_eng )
  end
end
