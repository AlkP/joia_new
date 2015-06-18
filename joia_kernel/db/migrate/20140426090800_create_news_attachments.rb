class CreateNewsAttachments < ActiveRecord::Migration
  def change
    create_table :news_attachments do |t|
      t.string      :name
      t.attachment  :att_file

      t.references  :news, index: true

      t.timestamps
    end
  end
end
