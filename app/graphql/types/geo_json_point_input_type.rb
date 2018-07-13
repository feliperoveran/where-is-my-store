class Types::GeoJsonPointInputType < Types::BaseInputObject
  description 'GeoJSON'

  argument :type, String, required: true
  argument :coordinates, Scalars::Point, required: true
end
