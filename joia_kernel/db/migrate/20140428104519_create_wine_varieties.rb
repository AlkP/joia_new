class CreateWineVarieties < ActiveRecord::Migration
  def change
    create_table :wine_varieties do |t|
      t.string    :name

      t.timestamps
    end
  end
end
