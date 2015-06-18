class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string      :name
      t.string      :name_eng

      t.integer :weight

      t.references  :country, index: true

      t.timestamps
    end
  end
end
