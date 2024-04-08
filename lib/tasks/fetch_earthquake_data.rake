require 'httparty'

namespace :earthquakes do
 desc "Fetch earthquake data from USGS and save it to the database"
 task fetch: :environment do
    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson"
    response = HTTParty.get(url)
    data = response.parsed_response['features']

    data.each do |earthquake_data|
      # Asegúrate de que los datos cumplan con los requisitos antes de intentar persistirlos
      next unless earthquake_data['properties']['title'] && earthquake_data['geometry']['coordinates']
    
      # Verificar rangos y no nulos
      next unless earthquake_data['properties']['mag'].between?(-1.0, 10.0) &&
                  earthquake_data['geometry']['coordinates'][1].between?(-90.0, 90.0) &&
                  earthquake_data['geometry']['coordinates'][0].between?(-180.0, 180.0)
     
      # Intenta crear un nuevo registro de terremoto
      earthquake = Earthquake.new(
         mag: earthquake_data['properties']['mag'],
         place: earthquake_data['properties']['place'],
         time: Time.at(earthquake_data['properties']['time'] / 1000), # Convertir de milisegundos a segundos
         url: earthquake_data['properties']['url'],
         tsunami: earthquake_data['properties']['tsunami'],
         mag_type: earthquake_data['properties']['magType'],
         title: earthquake_data['properties']['title'],
         latitude: earthquake_data['geometry']['coordinates'][1],
         longitude: earthquake_data['geometry']['coordinates'][0]
      )
     
      if earthquake.save
         puts "Earthquake saved successfully: #{earthquake.id}"
      else
         puts "Failed to save earthquake: #{earthquake.errors.full_messages.join(', ')}"
      end
     end
     
 end
end
