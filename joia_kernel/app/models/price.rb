class Price < ActiveRecord::Base
  has_many :catalog
  has_many :type
end
