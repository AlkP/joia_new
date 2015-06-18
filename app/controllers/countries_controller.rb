class CountriesController < ApplicationController
  before_filter :check_admin
  def index
    @countries = Country.all.order('weight ASC')
    @new_country = Country.new
  end
  def create
    Country.create(countries_params)
    redirect_to(countries_path)
  end
  def destroy
    Country.find(params[:id]).destroy
    redirect_to(countries_path)
  end
  def show
    @country_id = params[:id]
    @regions = Region.where('country_id = ?', params[:id]).order('weight ASC')
    @new_region = Region.new
  end
  def edit
    @country = Country.find(params[:id])
  end
  def update
    country = Country.find(params[:id])
    country.update(countries_params)
    @new_country = Country.new
    @countries = Country.all.order('weight ASC')
  end
  def send_country_sortable
    result = JSON.parse(params["arr_country"])
    weight = 0
    result.each do |res|
      Country.find(res['id']).update(weight: weight)
      weight += 1
    end
  end
  private
  def countries_params
    params.require(:country).permit( :name, :name_eng)
  end
end
