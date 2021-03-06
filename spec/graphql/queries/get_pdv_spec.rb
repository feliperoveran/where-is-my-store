# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'get_pdv GraphQL query' do
  it 'returns a store with the given ID' do
    store = create(:store)

    query_string = <<-QUERY
      {
        getPdv(id: #{store.id}) {
          id
          name
          owner
          document
          address
          coverageArea
        }
      }
    QUERY

    response = WhereIsMyStoreSchema.execute query_string

    expect(response.to_h.deep_symbolize_keys).to eq(
      data: {
        getPdv: {
          id: store.id.to_s,
          name: store.name,
          owner: store.owner,
          document: store.document,
          address: {
            type: 'Point',
            coordinates: store.address.coordinates
          },
          coverageArea: {
            type: 'MultiPolygon',
            coordinates: store.coverage_area.coordinates
          }
        }
      }
    )
  end

  it 'returns an error when the store could not be found' do
    query_string = %|{ getPdv(id: 69) { id } }|

    response = WhereIsMyStoreSchema.execute query_string

    expect(response.to_h.deep_symbolize_keys).to match(
      data: nil,
      errors: [
        a_hash_including(message: "Couldn't find Store with 'id'=69")
      ]
    )
  end
end
