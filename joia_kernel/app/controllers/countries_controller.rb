class CountriesController < ApplicationController
  before_filter :check_admin
  def index
    @countries = Country.all
    @new_country = Country.new
  end
  def create
    Country.create(name: params[:country][:name])
    redirect_to(countries_path)
  end
  def destroy
    Country.find(params[:id]).destroy
    redirect_to(countries_path)
  end
  def show
    @country_id = params[:id]
    @regions = Region.where('country_id = ?', params[:id])
    @new_region = Region.new
  end
end
