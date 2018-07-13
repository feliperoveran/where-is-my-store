class Types::GeoJsonMultiPolygonInputType < Types::BaseInputObject
  description 'GeoJSON'

  argument :type, String, required: true
  argument :coordinates, Scalars::MultiPolygon, required: true
end
