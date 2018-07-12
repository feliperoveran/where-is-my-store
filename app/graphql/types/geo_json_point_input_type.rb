class Types::GeoJsonPointInputType < Types::BaseInputObject
  description 'GeoJSON'

  argument :type, String, required: true
  argument :coordinates, Types::PointType, required: true
end
