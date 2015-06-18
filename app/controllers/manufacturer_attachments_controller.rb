class ManufacturerAttachmentsController < ApplicationController
  def create
    manufacturer_att = ManufacturerAttachment.create(manufacturer_attachments_params)
    params_id = manufacturer_att.manufacturer_id

    @manufacturers = Manufacturer.all.order('weight ASC')
    @manufacturer = Manufacturer.find(params_id)
    @countries = Country.all.order('weight ASC')
    @regions = Region.all.order('weight ASC')
    @regions_one = Region.all.order('weight ASC').where("country_id = ?", @manufacturer.country_id)
    @manufacturer_attachments = ManufacturerAttachment.where('manufacturer_id = ?', params_id)
    @new_manufacturer_attachment = ManufacturerAttachment.new

  end
  def destroy
    params_id = ManufacturerAttachment.find(params[:id]).manufacturer_id
    ManufacturerAttachment.find(params[:id]).destroy
    @manufacturer = Manufacturer.find(params_id)
    @manufacturer_attachments = ManufacturerAttachment.where('manufacturer_id = ?', params_id)
    @new_manufacturer_attachment = ManufacturerAttachment.new
  end

  private
  def manufacturer_attachments_params
    params.require(:manufacturer_attachment).permit( :manufacturer_id, :photo )
  end
end
