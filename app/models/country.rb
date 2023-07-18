class Country < ApplicationRecord
  has_many :city_bikes
  has_many :cities

  validates :name, presence: true
end
