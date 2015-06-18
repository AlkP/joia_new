class RegionsController < ApplicationController
  before_filter :check_admin
  def create
    region = Region.create(regions_params)
    @country_id = region.country_id
    @regions = Region.where('country_id = ?', @country_id)
    @new_region = Region.new
  end
  def destroy
    region = Region.find(params[:id])
    @country_id = region.country_id
    region.destroy
    @regions = Region.where('country_id = ?', @country_id)
    @new_region = Region.new
  end
  private
  def regions_params
    params.require(:region).permit( :name, :country_id)
  end
end
