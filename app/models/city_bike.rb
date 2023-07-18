class CityBike < ApplicationRecord
  belongs_to :country
  belongs_to :city

  validates :name, presence:true
end
