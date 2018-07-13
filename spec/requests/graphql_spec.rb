# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphQL route sanity check' do
  it 'should return http status ok' do
    post '/graphql'

    expect(response).to have_http_status :ok
  end
end
