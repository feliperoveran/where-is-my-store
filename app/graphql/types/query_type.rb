# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :get_pdv, Types::StoreType, null: false do
      argument :id, required: true, type: ID
      description 'Find a PDV based on its ID'
    end

    field :search_pdv, Types::StoreType, null: true do
      argument :latitude, required: true, type: Float
      argument :longitude, required: true, type: Float
      description 'Find the nearest PDV'
    end

    def get_pdv(args)
      Store.find(args[:id])
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new(e.message)
    end

    def search_pdv(args)
      Store.nearest(args[:latitude], args[:longitude])
    end
  end
end
