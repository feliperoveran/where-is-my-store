class Store < ApplicationRecord
  validates_presence_of :name, :owner, :document, :coverage_area, :address

  def self.from_json!(json)
    create!(
      id: json['id'],
      name: json['tradingName'],
      owner: json['ownerName'],
      document: json['document'],
      coverage_area: RGeo::GeoJSON.decode(json['coverageArea']),
      address: RGeo::GeoJSON.decode(json['address'])
    )
  end
end
