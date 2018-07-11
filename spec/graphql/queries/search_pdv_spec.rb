require 'rails_helper'

RSpec.describe 'searchPdv GraphQL query' do
  it 'returns the nearest store' do
    create(
      :store,
      coverage_area: 'MULTIPOLYGON (((0 0, 10 0, 10 10, 0 10, 0 0)))',
      address: 'POINT(8 8)'
    )

    nearest_store = create(
      :store,
      coverage_area: 'MULTIPOLYGON (((-4 5, 3 5, 2 1, 1 -2, -4 -2, -4 5)))',
      address: 'POINT(1 2)'
    )

    query_string =<<-QUERY
      {
        searchPdv(latitude: 1, longitude: 3){
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
        searchPdv: {
          id: nearest_store.id.to_s,
          name: nearest_store.name,
          owner: nearest_store.owner,
          document: nearest_store.document,
          address: nearest_store.address.as_json,
          coverageArea: nearest_store.coverage_area.as_json
        }
      }
    )
  end
end