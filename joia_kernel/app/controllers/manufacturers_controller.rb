class ManufacturersController < ApplicationController
  before_filter :check_admin
  def index
    @manufacturers = Manufacturer.all
  end
  def new
    @manufacturer = Manufacturer.new
    @countries = Country.all
    @regions = Region.all
  end
  def create
    Manufacturer.create(manufacturer_params)
    redirect_to(manufacturers_path)
  end
  def update
    Manufacturer.find(params[:id]).update(manufacturer_params)
    redirect_to(manufacturers_path)
  end
  def show
    @manufacturer = Manufacturer.find(params[:id])
    @countries = Country.all
    @regions = Region.all
    @regions_one = Region.all.where("country_id = ?", @manufacturer.country_id)
  end
  def destroy
    Manufacturer.find(params[:id]).destroy
    redirect_to(manufacturers_path)
  end
  private
  def manufacturer_params
    params.require(:manufacturer).permit( :name, :country_id, :region_id )
  end
end
