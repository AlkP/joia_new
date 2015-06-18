class SearchCategory < ActiveRecord::Base
  belongs_to :catalog
  has_attached_file :logo
  do_not_validate_attachment_file_type :logo
end
