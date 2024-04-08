class EarthquakeSerializer < ActiveModel::Serializer
  attributes :id, :type, :attributes, :links
 
  def type
     'feature'
  end
 
  def attributes
     {
       external_id: object.id,
       magnitude: object.mag,
       place: object.place,
       time: object.time.iso8601,
       tsunami: object.tsunami,
       mag_type: object.mag_type,
       title: object.title,
       coordinates: {
         longitude: object.longitude,
         latitude: object.latitude
       }
     }
  end
 
  def links
     {
       external_url: object.url
     }
  end
 end
 