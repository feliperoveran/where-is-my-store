class Store < ApplicationRecord
  validates_presence_of :name, :owner, :document, :coverage_area, :address

  def self.from_json!(json)
    json = json.with_indifferent_access.transform_keys! { |k| k.camelize :lower }

    create!(
      id: json[:id],
      name: json[:tradingName],
      owner: json[:ownerName],
      document: json[:document],
      coverage_area: RGeo::GeoJSON.decode(json[:coverageArea].to_h.to_json),
      address: RGeo::GeoJSON.decode(json[:address].to_h.to_json)
    )
  end
end
