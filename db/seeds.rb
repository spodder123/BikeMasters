# seeds.rb
require 'faker'
require 'json'
require 'net/http'

# Fetch data from the API
url = 'http://api.citybik.es/v2/networks'
uri = URI(url)

begin
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  if data['networks'].is_a?(Array)
    # Seed countries and cities using API data
    data['networks'].each do |network|
      country_name = network['location']['country']
      country = Country.find_or_create_by(name: country_name)

      if network['location']['cities'].is_a?(Array)
        network['location']['cities'].each do |city_data|
          city_name = city_data['name']
          city = City.find_or_create_by(name: city_name, country_id: country.id)

          if city_data['stations'].is_a?(Array)
            city_data['stations'].each do |station|
              bike_name = station['name']
              bike_company = station['extra']['company']

              # Seed city_bikes using the data from the API and Faker for prices
              CityBike.create(
                name: bike_name,
                company: bike_company,
                country_id: country.id,
                city_id: city.id,
                price: Faker::Commerce.price(range: 50..300) # Generate random prices between 50 and 300
              )
            end
          end
        end
      end
    end
  else
    puts "API response format is not as expected. Please check the API data."
  end

rescue StandardError => e
  puts "Error fetching or parsing API data: #{e.message}"
end
