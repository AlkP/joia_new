class CategoriesController < ApplicationController
  before_filter :check_admin
  def index
    @categories = Category.all
    @category = Category.new
  end
  def create
    Category.create(name: params[:category][:name])
    redirect_to(categories_path)
  end
  def destroy
    Category.find(params[:id]).destroy
    redirect_to(categories_path)
  end
end
