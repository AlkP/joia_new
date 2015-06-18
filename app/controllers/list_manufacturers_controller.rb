class ListManufacturersController < ApplicationController
  include ApplicationHelper
  def show

    filter = Hash.new
    filter["country"] = Array.new
    filter["region"] = Array.new
    filter["search_category"] = Array.new
    filter["manufacturer"] = Array.new
    filter["price"] = Array.new
    filter["open_list"] = Hash.new

    filter["manufacturer"] << params[:id]

    filter["hard_liquor"] = false

    session[:filter]      = filter

    session[:sort]        = "search_category"

    @catalogs = apply_filter
    @manufacturer = Manufacturer.find(params[:id])
    @manufacturer_attachments = ManufacturerAttachment.where('manufacturer_id = ?', params[:id])
  end
end
