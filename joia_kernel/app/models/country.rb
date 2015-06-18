class Country < ActiveRecord::Base
  has_many :region, dependent: :destroy
  belongs_to :manufacturer
end
