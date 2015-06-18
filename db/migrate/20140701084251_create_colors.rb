class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string    :name
      t.string    :name_eng

      t.integer   :weight
      t.boolean   :hard_liquor

      t.attachment  :logo

      t.timestamps
    end
  end
end
