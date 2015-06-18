class CategoriesController < ApplicationController
  before_filter :check_admin
  def index
    @categories = Category.all
  end
  def new
    @category = Category.new
  end
  def create
    Category.create(category_params)
    redirect_to(categories_path)
  end
  def update
    Category.find(params[:id]).update(category_params)
    redirect_to(categories_path)
  end
  def show
    @category = Category.find(params[:id])
  end
  def destroy
    Category.find(params[:id]).destroy
    redirect_to(categories_path)
  end
  private
  def category_params
    params.require(:category).permit( :name )
  end
end
