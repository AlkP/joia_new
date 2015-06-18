# encoding: UTF-8
class Catalog < ActiveRecord::Base
  has_attached_file :avatar

  belongs_to :price
  belongs_to :catalog_wine_variety

  has_many :manufacturer
  has_many :category
  has_many :color

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each  do |catalog|
        csv << catalog.attributes.values_at(*column_names)
      end
    end
  end
end
