require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :owner }
  it { should validate_presence_of :document }
  it { should validate_presence_of :coverage_area }
  it { should validate_presence_of :address }

  describe '.from_json!' do
    it 'creates a new Store' do
      json = JSON.parse file_fixture('store.json').read

      expect {
        described_class.from_json! json
      }.to change { Store.count }.by 1
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

      expect {
        described_class.from_json! json
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
