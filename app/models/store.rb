class Store < ApplicationRecord
  validates_presence_of :name, :owner, :document, :coverage_area, :address
end
