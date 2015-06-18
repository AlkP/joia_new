class CreateManufacturerAttachments < ActiveRecord::Migration
  def change
    create_table :manufacturer_attachments do |t|
      t.references  :manufacturer, index: true
      t.attachment  :photo
      t.timestamps
    end
  end
end
