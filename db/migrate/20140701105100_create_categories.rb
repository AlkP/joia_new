class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string  :name

      t.integer :weight

      t.timestamps
    end
  end
end