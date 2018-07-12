class Types::MutationType < Types::BaseObject
  field :create_pdv, Types::StoreType, null: false do
    description 'Create a new PDV'

    argument :id, ID, required: true
    argument :trading_name, String, required: true
    argument :owner_name, String, required: true
    argument :document, String, required: true
    argument :address, Types::GeoJsonPointInputType, required: true
    argument :coverage_area, Types::GeoJsonMultiPolygonInputType, required: true
  end

  def create_pdv(args)
    Store.from_json! args
  end
end
