class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string      :name
      t.string      :name_eng

      t.string      :row1
      t.string      :row2

      t.integer     :weight

      t.attachment  :slide
      t.attachment  :logo

      t.references  :country, index: true
      t.references  :region, index: true

      t.timestamps
    end
  end
end
