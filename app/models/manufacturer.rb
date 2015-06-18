class Manufacturer < ActiveRecord::Base
  belongs_to :catalog
  has_many :country
  has_many :region
  has_many :manufacturer_attachment
  has_attached_file :slide
  has_attached_file :logo
  do_not_validate_attachment_file_type :slide
  do_not_validate_attachment_file_type :logo
end
