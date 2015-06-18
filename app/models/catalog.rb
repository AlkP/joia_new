class Catalog < ActiveRecord::Base

  has_attached_file :avatar
  has_attached_file :photo_best
  has_attached_file :photo_original

  has_attached_file :interesting_background_image
  has_attached_file :interesting_background_bottle
  has_attached_file :interesting_offers_logo

  do_not_validate_attachment_file_type :avatar
  do_not_validate_attachment_file_type :photo_best
  do_not_validate_attachment_file_type :photo_original

  do_not_validate_attachment_file_type :interesting_background_image
  do_not_validate_attachment_file_type :interesting_background_bottle
  do_not_validate_attachment_file_type :interesting_offers_logo

  belongs_to :price
  belongs_to :catalog_wine_variety

  has_many :sugar
  has_many :manufacturer
  has_many :category
  has_many :search_category
  has_many :color

  scope :by_color, :joins => "left join colors on catalogs.color_id = colors.id", :order => "colors.weight"

end
