# frozen_string_literal: true

class Store < ApplicationRecord
  INVALID_DOCUMENT_MESSAGE = 'Document must have either 11 or 14 digits,'\
    ' ignoring punctuation.'

  before_validation :remove_document_punctuation
  validates_presence_of :name, :owner, :document, :coverage_area, :address
  validate :document_format
  validates_uniqueness_of :document, case_sensitive: false

  # rubocop:disable Metrics/AbcSize
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
  # rubocop:enable Metrics/AbcSize

  def self.nearest(lat, long)
    point = "ST_GeomFromText('POINT(#{lat} #{long})', 0)"

    Store
      .where(Arel.sql("ST_Within(#{point}, stores.coverage_area)"))
      .order(Arel.sql("ST_Distance(#{point}, stores.address)"))
      .limit(1)
      .first
  end

  private

    def document_format
      unless document.present? && (document.size == 11 || document.size == 14)
        errors.add(:document, INVALID_DOCUMENT_MESSAGE)
      end
    end

    def remove_document_punctuation
      self.document = document&.gsub(/\.|\/|-/, '')
    end
end
