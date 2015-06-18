module CatalogsHelper
  def init
    @manufacturers = Manufacturer.all
    @categories = Category.all
    @colors = Color.all
    @types = Type.all
    @wine_variety = WineVariety.all
  end
  def init_wine_varieties
    @wine_variety = WineVariety.all
  end
end
