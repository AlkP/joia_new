class ManufacturersController < ApplicationController
  before_filter :check_admin
  def index
    @manufacturers = Manufacturer.all.order('weight ASC')
  end
  def new
    @manufacturer = Manufacturer.new
    @countries = Country.all.order('weight ASC')
    @regions = Region.all.order('weight ASC')
    @regions_one = Region.all.order('weight ASC').where("country_id = ?", @manufacturer.country_id)
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
    @countries = Country.all.order('weight ASC')
    @regions = Region.all.order('weight ASC')
    @regions_one = Region.all.order('weight ASC').where("country_id = ?", @manufacturer.country_id)
    @manufacturer_attachments = ManufacturerAttachment.where('manufacturer_id = ?', params[:id])
    @new_manufacturer_attachment = ManufacturerAttachment.new
  end
  def destroy
    Manufacturer.find(params[:id]).destroy
    redirect_to(manufacturers_path)
  end
  def del_slide
    Manufacturer.find(params[:id]).slide.destroy
    redirect_to(manufacturers_path)
  end
  def del_logo
    Manufacturer.find(params[:id]).logo.destroy
    redirect_to(manufacturers_path)
  end
  def send_manufacturer_sortable
    result = JSON.parse(params["arr_manufacturer"])
    weight = 0
    result.each do |res|
      Manufacturer.find(res['id']).update(weight: weight)
      weight += 1
    end
  end
  private
  def manufacturer_params
    params.require(:manufacturer).permit( :name, :name_eng, :row1, :row2, :country_id, :region_id, :slide, :logo )
  end
end
