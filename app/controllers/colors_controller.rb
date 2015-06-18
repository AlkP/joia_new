class ColorsController < ApplicationController
  before_filter :check_admin
  def index
    @colors = Color.all.order('weight ASC')
  end
  def new
    @color = Color.new
  end
  def create
    Color.create(color_params)
    redirect_to(colors_path)
  end
  def update
    Color.find(params[:id]).update(color_params)
    redirect_to(colors_path)
  end
  def show
    @color = Color.find(params[:id])
  end
  def destroy
    Color.find(params[:id]).destroy
    redirect_to(colors_path)
  end
  def send_color_sortable
    result = JSON.parse(params["arr_color"])
    weight = 0
    result.each do |res|
      Color.find(res['id']).update(weight: weight)
      weight += 1
    end
  end
  private
  def color_params
    params.require(:color).permit( :name, :name_eng, :hard_liquor, :logo )
  end
end
