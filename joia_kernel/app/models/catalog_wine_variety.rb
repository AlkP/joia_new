class CatalogWineVariety < ActiveRecord::Base
  has_many :catalog
  has_many :wine_variety
end
