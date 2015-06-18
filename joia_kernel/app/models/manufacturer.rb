class Manufacturer < ActiveRecord::Base
  belongs_to :catalog

  has_many :country
  has_many :region
end
