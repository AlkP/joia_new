class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.string      :name
      t.string      :name_original
      t.text        :description
      t.float       :abv
      t.float       :volume
      t.integer     :amount
      t.integer     :honors
      t.integer     :barcode

      t.attachment  :avatar

      t.references  :manufacturer, index: true
      t.references  :category, index: true
      t.references  :color, index: true

      t.timestamps
    end
  end
end
