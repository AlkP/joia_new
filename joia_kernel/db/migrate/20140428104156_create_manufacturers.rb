class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string      :name

      t.references  :country, index: true
      t.references  :region, index: true

      t.timestamps
    end
  end
end
