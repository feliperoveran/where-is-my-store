# frozen_string_literal: true

Scalars::MultiPolygon = GraphQL::ScalarType.define do
  name 'MultiPolygon'
  description 'The MultiPolygon type represents a geo multipolygon used to represent an area'

  coerce_input ->(value, _ctx) { value }
  coerce_result ->(value, _ctx) { RGeo::GeoJSON.encode(value) }
end
