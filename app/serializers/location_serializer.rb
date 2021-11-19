class LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location_title, :street_number, :locality, :postal_code, :latitude, :longitude, :place_id, :country, :facility_name
  
end
