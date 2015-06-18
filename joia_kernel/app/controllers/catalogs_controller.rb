class CatalogsController < ApplicationController
  before_filter :check_admin
  def index
    @catalogs = Catalog.all
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
  end
  def add_new_wine_variety
    CatalogWineVariety.create(percent: params[:new][:percent],
                              catalog_id: params[:new][:catalog_id],
                              wine_variety_id: params[:new][:wine_variety_id])
    @catalog_w_v = CatalogWineVariety.where('catalog_id = ?', params[:new][:catalog_id])
  end
  private
  def catalogs_params
    params.require(:catalog).permit( :name,
                                     :name_original,
                                     :description,
                                     :abv,
                                     :volume,
                                     :amount,
                                     :honors,
                                     :barcode,
                                     :avatar,

                                     :manufacturer_id,
                                     :category_id,
                                     :color_id )
  end
  def save_price(id, price, discount)
    Price.where('catalog_id = ?', id.to_i).destroy_all
    Type.all.each do |type|
      Price.create(catalog_id: id, type_id: type.id, price: price[type.id.to_s].to_i, discount: discount[type.id.to_s].to_i)
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
