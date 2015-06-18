class CreateCatalogWineVarieties < ActiveRecord::Migration
  def change
    create_table :catalog_wine_varieties do |t|
      t.float       :percent

      t.references  :wine_variety, index: true
      t.references  :catalog, index: true

      t.timestamps
    end
  end
end
