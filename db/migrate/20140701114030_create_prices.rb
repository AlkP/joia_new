class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.float     :price
      t.float     :discount

      t.references  :type, index: true
      t.references  :catalog, index: true

      t.timestamps
    end
  end
end
