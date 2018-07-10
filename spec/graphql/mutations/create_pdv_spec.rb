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

    WhereIsMyStoreSchema.execute(query_string)

    expect(Store.last).to have_attributes(
      id: 69,
      name: 'Loja do Monstro',
      owner: 'O monstro',
      document: '02.453.716/000170',
      address: RGeo::Cartesian.factory.parse_wkt("POINT (1.0 2.0)"),
      coverage_area: RGeo::Cartesian.factory.parse_wkt(
        "MULTIPOLYGON " \
        "(((30.0 20.0, 45.0 40.0, 10.0 40.0, 30.0 20.0))," \
        "((15.0 5.0, 40.0 10.0, 10.0 20.0, 5.0 10.0, 15.0 5.0)))"
      )
    )
  end
end
