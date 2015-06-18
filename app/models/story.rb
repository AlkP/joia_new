class Story < ActiveRecord::Base
  has_many :stories_attachment, dependent: :destroy
  has_attached_file :avatar
  do_not_validate_attachment_file_type :avatar
end
