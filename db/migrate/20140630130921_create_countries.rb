class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string  :name
      t.string  :name_eng

      t.integer :weight

      t.timestamps
    end
  end
end
