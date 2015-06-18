class NewsAttachment < ActiveRecord::Base
  belongs_to :news
  has_attached_file :att_file
end
