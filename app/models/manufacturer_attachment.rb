class ManufacturerAttachment < ActiveRecord::Base
  has_attached_file :photo
  belongs_to :manufacturer
  do_not_validate_attachment_file_type :photo
end
