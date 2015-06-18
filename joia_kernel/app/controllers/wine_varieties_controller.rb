class WineVarietiesController < ApplicationController
  before_filter :check_admin
  def index
    @wine_varieties = WineVariety.all
    @wine_variety = WineVariety.new
  end
  def create
    WineVariety.create(name: params[:wine_variety][:name])
    redirect_to(wine_varieties_path)
  end
  def destroy
    WineVariety.find(params[:id]).destroy
    redirect_to(wine_varieties_path)
  end
end
