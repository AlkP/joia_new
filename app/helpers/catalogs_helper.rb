module CatalogsHelper
  def init
    @sugars = Sugar.all
    @manufacturers = Manufacturer.all
    @categories = Category.all
    @colors = Color.all
    @search_categories = SearchCategory.all
    @types = Type.all
    @wine_variety = WineVariety.all
  end
  def init_wine_varieties
    @wine_variety = WineVariety.all
  end
end
