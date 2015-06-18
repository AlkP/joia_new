class AddcColumnSearchCategoryCatalog < ActiveRecord::Migration
  def change
    change_table :catalogs do |t|

      t.references  :search_category, index: true

    end
  end
end
