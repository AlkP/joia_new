class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string    :title
      t.string    :intro_text
      t.string    :large_title
      t.text      :large_text
      t.attachment  :avatar

      t.integer     :weight

      t.timestamps
    end
  end
end
