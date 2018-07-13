class Types::StoreType < Types::BaseObject
  description 'An instance of a store, or PDV'

  field :id, ID, null: false
  field :name, String, null: false
  field :owner, String, null: false
  field :document, String, null: false
  field :address, Scalars::Point, null: false
  field :coverage_area, String, null: false
end
