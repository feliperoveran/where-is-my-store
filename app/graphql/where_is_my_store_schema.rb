# frozen_string_literal: true

class WhereIsMyStoreSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
