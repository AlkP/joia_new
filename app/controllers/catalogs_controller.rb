class CatalogsController < ApplicationController
  before_filter :check_admin, except: [:index]
  # before_filter :check_admin, except: [:index, :show]
  before_filter :check_user, except: [:index]
  include ApplicationHelper
  def index
    unless current_user
      @filter = session[:filter]
      @catalogs = apply_filter
    else
      unless current_user.admin?
        @filter = session[:filter]
        @catalogs = apply_filter
      else
        @catalogs = Catalog.all.order('weight ASC')
      end
    end
    checkFilter
  end
  def new
    @catalog = Catalog.new
  end
  def show
    @catalog = Catalog.find(params[:id])
    @prices = Price.where('catalog_id = ?', params[:id])
    @catalog_w_v = CatalogWineVariety.where('catalog_id = ?', params[:id])
  end
  def create
    catalog = Catalog.create(catalogs_params)
    save_price(catalog.id, params[:price], params[:discount])
    save_wine_varieties(catalog.id, params[:variety])
    redirect_to(catalogs_path)
  end
  def update
    Catalog.find(params[:id]).update(catalogs_params)
    save_price(params[:id], params[:price], params[:discount])
    save_wine_varieties(params[:id], params[:variety])
    redirect_to(catalogs_path)
  end
  def destroy
    Catalog.find(params[:id]).destroy
    Price.where('catalog_id = ?', params[:id]).destroy_all
    redirect_to(catalogs_path)
  end
  def destroy_wine_variety
    id = CatalogWineVariety.find(params[:id]).catalog_id
    CatalogWineVariety.find(params[:id]).destroy
    @catalog_w_v = CatalogWineVariety.where('catalog_id = ?', id)

    redirect_to '/catalogs/'+id.to_s
  end
  def add_new_wine_variety
    CatalogWineVariety.create(percent: params[:new][:percent],
                              catalog_id: params[:new][:catalog_id],
                              wine_variety_id: params[:new][:wine_variety_id])
    @catalog_w_v = CatalogWineVariety.where('catalog_id = ?', params[:new][:catalog_id])
    redirect_to '/catalogs/'+params[:new][:catalog_id]
  end
  def send_catalog_sortable
    result = JSON.parse(params["arr_catalog"])
    weight = 0
    result.each do |res|
      Catalog.find(res['id']).update(weight: weight)
      weight += 1
    end
  end
  private
  def catalogs_params
    params.require(:catalog).permit( :name,
                                     :name_eng,
                                     :description,
                                     :description_eng,
                                     :abv,
                                     :volume,
                                     :amount,
                                     :honors,
                                     :barcode,
                                     :year,
                                     :hard_liquor,
                                     :interesting,
                                     :interesting_description_rus,
                                     :interesting_description_fr,
                                     :interesting_row1,
                                     :interesting_row2,

                                     :avatar,
                                     :photo_best,
                                     :photo_original,

                                     :interesting_background_image,
                                     :interesting_background_bottle,
                                     :interesting_offers_logo,

                                     :sugar_id,
                                     :manufacturer_id,
                                     :category_id,
                                     :color_id,
                                     :search_category_id )
  end
  def save_price(id, price, discount)
    Price.where('catalog_id = ?', id.to_i).destroy_all
    Type.all.each do |type|
      Price.create(catalog_id: id, type_id: type.id, price: price[type.id.to_s].to_f, discount: discount[type.id.to_s].to_f)
    end
  end
  def save_wine_varieties(id, variety)
    CatalogWineVariety.where('catalog_id = ?', id.to_i).destroy_all
    unless variety.nil?
      variety.each_key do |v|
        CatalogWineVariety.create(wine_variety_id: v.to_i, catalog_id: id.to_i, percent: variety[v].to_i) unless variety[v].to_i == 0
      end
    end
  end
end
