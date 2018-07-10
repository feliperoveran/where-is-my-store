class Types::GeoJsonMultiPolygonType < Types::BaseInputObject
  description 'GeoJSON'

  argument :type, String, required: true
  argument :coordinates, [[[[Float]]]], required: true
end
