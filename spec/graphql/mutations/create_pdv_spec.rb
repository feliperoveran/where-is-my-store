# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'createPdv GraphQL mutation' do
  it 'creates a new PDV with the correct attributes' do
    query_string = <<-MUTATION
      mutation {
        createPdv(
          id: 69,
          tradingName: "Loja do Monstro",
          ownerName: "O monstro",
          document: "02.453.716/000170",
          address: {
            type: "Point",
            coordinates: [1, 2]
          },
          coverageArea: {
            type: "MultiPolygon",
            coordinates: [
              [[[30, 20], [45, 40], [10, 40], [30, 20]]],
              [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
            ]
          }
        )
        {
          id
          name
          owner
          document
          address
          coverageArea
        }
      }
    MUTATION

    response = WhereIsMyStoreSchema.execute(query_string)

    expect(response.to_h.deep_symbolize_keys).to eq(
      data: {
        createPdv: {
          id: Store.last.id.to_s,
          name: Store.last.name,
          owner: Store.last.owner,
          document: Store.last.document,
          address: {
            type: 'Point',
            coordinates: Store.last.address.coordinates
          },
          coverageArea: {
            type: 'MultiPolygon',
            coordinates: Store.last.coverage_area.coordinates
          }
        }
      }
    )
  end

  it 'returns an error message when the creation fails' do
    query_string = <<-MUTATION
      mutation {
        createPdv(
          tradingName: "",
          ownerName: "O monstro",
          document: "02.453.716/000170",
          address: {
            type: "Point",
            coordinates: [1, 2]
          },
          coverageArea: {
            type: "MultiPolygon",
            coordinates: [
              [[[30, 20], [45, 40], [10, 40], [30, 20]]],
              [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
            ]
          }
        )
        {
          id
          name
          owner
          document
          address
          coverageArea
        }
      }
    MUTATION

    response = WhereIsMyStoreSchema.execute(query_string)

    expect(response.to_h.deep_symbolize_keys).to match(
      data: nil,
      errors: [
        a_hash_including(message: "Validation failed: Name can't be blank")
      ]
    )
  end
end
