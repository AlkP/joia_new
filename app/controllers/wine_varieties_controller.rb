class WineVarietiesController < ApplicationController
  before_filter :check_admin
  def index
    @wine_varieties = WineVariety.all
  end
  def new
    @wine_variety = WineVariety.new
  end
  def create
    WineVariety.create(wine_variety_params)
    redirect_to(wine_varieties_path)
  end
  def update
    WineVariety.find(params[:id]).update(wine_variety_params)
    redirect_to(wine_varieties_path)
  end
  def show
    @wine_variety = WineVariety.find(params[:id])
  end
  def destroy
    WineVariety.find(params[:id]).destroy
    redirect_to(wine_varieties_path)
  end
  private
  def wine_variety_params
    params.require(:wine_variety).permit( :name, :name_eng )
  end
end
