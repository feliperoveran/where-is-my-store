# frozen_string_literal: true

Types::PointType = GraphQL::ScalarType.define do
  name 'Point'
  description 'The Point type represents a geo point with a latitude-longitude value pair.'

  coerce_input ->(value, ctx) { value }
  coerce_result ->(value, ctx) { value.to_s }
end
