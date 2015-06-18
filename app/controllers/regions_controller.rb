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
  def send_region_sortable
    result = JSON.parse(params["arr_region"])
    weight = 0
    result.each do |res|
      Region.find(res['id']).update(weight: weight)
      weight += 1
    end
  end
  def edit
    @region = Region.find(params[:id])
  end
  def update
    region = Region.find(params[:id])
    region.update(regions_params)
    @regions = Region.where('country_id = ?', region.country_id).order('weight ASC')
  end
  private
  def regions_params
    params.require(:region).permit( :name, :name_eng, :country_id)
  end
end
