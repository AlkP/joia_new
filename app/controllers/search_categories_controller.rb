class SearchCategoriesController < ApplicationController
  before_filter :check_admin
  def index
    @search_categories = SearchCategory.all.order('weight ASC')
  end
  def new
    @search_category = SearchCategory.new
  end
  def create
    SearchCategory.create(search_category_params)
    redirect_to(search_categories_path)
  end
  def update
    SearchCategory.find(params[:id]).update(search_category_params)
    redirect_to(search_categories_path)
  end
  def show
    @search_category = SearchCategory.find(params[:id])
  end
  def destroy
    SearchCategory.find(params[:id]).destroy
    redirect_to(search_categories_path)
  end
  def send_search_category_sortable
    result = JSON.parse(params["arr_search_category"])
    weight = 0
    result.each do |res|
      SearchCategory.find(res['id']).update(weight: weight)
      weight += 1
    end
  end
  private
  def search_category_params
    params.require(:search_category).permit( :name, :name_eng, :hard_liquor, :logo )
  end
end
