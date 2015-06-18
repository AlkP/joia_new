class News < ActiveRecord::Base
  has_many :news_attachments, dependent: :destroy
end
