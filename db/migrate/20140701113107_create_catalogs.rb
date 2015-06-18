class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.string      :name
      t.string      :name_eng
      t.text        :description
      t.text        :description_eng
      t.float       :abv
      t.float       :volume
      t.integer     :amount
      t.integer     :honors
      t.integer     :barcode
      t.boolean     :hard_liquor
      t.string      :year

      t.integer     :weight

      t.boolean     :interesting
      t.text        :interesting_description_rus
      t.text        :interesting_description_fr
      t.text        :interesting_row1
      t.text        :interesting_row2

      t.attachment  :avatar
      t.attachment  :photo_best
      t.attachment  :photo_original

      t.attachment  :interesting_background_image
      t.attachment  :interesting_background_bottle
      t.attachment  :interesting_offers_logo

      t.references  :sugar, index: true
      t.references  :manufacturer, index: true
      t.references  :category, index: true
      t.references  :color, index: true

      t.timestamps
    end
  end
end
