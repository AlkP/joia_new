class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string      :name
      t.string      :name_eng

      t.timestamps
    end
  end
end
