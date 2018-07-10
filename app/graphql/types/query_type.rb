class Types::QueryType < Types::BaseObject
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :get_pdv, Types::StoreType, null: false do
    argument :id, required: true, type: ID
    description 'Find a PDV based on its ID'
  end

  def get_pdv(args)
    Store.find(args[:id])
  rescue ActiveRecord::RecordNotFound => e
    GraphQL::ExecutionError.new(e.message)
  end
end
