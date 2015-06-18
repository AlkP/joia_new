class CreateSugars < ActiveRecord::Migration
  def change
    create_table :sugars do |t|
      t.string  :name
      t.string  :name_eng

      t.timestamps
    end
  end
end
