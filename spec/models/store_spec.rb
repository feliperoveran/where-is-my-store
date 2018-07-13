# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Store, type: :model do
  ###################
  ### Validations ###
  ###################
  it { should validate_presence_of :name }
  it { should validate_presence_of :owner }
  it { should validate_presence_of :document }
  it { should validate_presence_of :coverage_area }
  it { should validate_presence_of :address }

  it 'validates uniqueness of document' do
    store = build(:store)

    expect(store).to validate_uniqueness_of(:document).case_insensitive
  end

  it 'allows document with 11 digits (cpf)' do
    store = build(:store, document: '12345678910')

    expect(store).to be_valid
  end

  it 'allows document with 14 digits (cnpj)' do
    store = build(:store, document: '30480374000112')

    expect(store).to be_valid
  end

  it 'does not considers punctuation when validating document' do
    store = build(:store, document: '30.480.374/0001-12')

    expect(store).to be_valid
  end

  it 'saves the document without punctuation' do
    store = build(:store, document: '123.456.789-10')

    store.save

    expect(store.document).to eq '12345678910'
  end

  #################
  ### from_json ###
  #################
  describe '.from_json!' do
    it 'creates a new Store' do
      json = JSON.parse file_fixture('store.json').read

      expect do
        described_class.from_json! json
      end.to change { Store.count }.by 1
    end

    it 'creates a new store with the right attributes' do
      json = JSON.parse file_fixture('store.json').read

      described_class.from_json! json

      expect(Store.last).to have_attributes(
        id: json['id'].to_i,
        name: json['tradingName'],
        owner: json['ownerName'],
        document: json['document'],
        coverage_area: RGeo::GeoJSON.decode(json['coverageArea']),
        address: RGeo::GeoJSON.decode(json['address'])
      )
    end

    it 'converts underscore names to camelCase names when creating a Store' do
      json = JSON.parse file_fixture('store_underscore_names.json').read

      described_class.from_json! json

      expect(Store.last).to have_attributes(
        id: json['id'].to_i,
        name: json['trading_name'],
        owner: json['owner_name'],
        document: json['document'],
        coverage_area: RGeo::GeoJSON.decode(json['coverage_area']),
        address: RGeo::GeoJSON.decode(json['address'])
      )
    end

    it 'raises ActiveRecord::RecordInvalid when the store is invalid' do
      json = JSON.parse file_fixture('invalid_store.json').read

      expect do
        described_class.from_json! json
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end

  ###############
  ### nearest ###
  ###############
  describe '.nearest' do
    it 'returns the nearest store from a point in the coverage area' do
      create(
        :store,
        coverage_area: 'MULTIPOLYGON (((0 0, 10 0, 10 10, 0 10, 0 0)))',
        address: 'POINT(8 8)'
      )

      nearest_store = create(
        :store,
        coverage_area: 'MULTIPOLYGON (((-4 5, 3 5, 2 1, 1 -2, -4 -2,-4 5)))',
        address: 'POINT(1 2)'
      )

      expect(described_class.nearest(2, 4)).to eq nearest_store
    end

    it 'returns nil when the point is not in the coverage area' do
      create(
        :store,
        coverage_area: 'MULTIPOLYGON (((-4 5, 3 5, 2 1, 1 -2, -4 -2,-4 5)))',
        address: 'POINT(1 2)'
      )

      expect(described_class.nearest(69, 69)).to be_nil
    end
  end
end
