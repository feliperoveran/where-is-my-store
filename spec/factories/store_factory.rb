FactoryBot.define do
  factory :store do
    name { FFaker::Company.name }
    owner { FFaker::NameBR.name }
    document { FFaker::IdentificationBR.cnpj }
    coverage_area "MULTIPOLYGON (((0 0, 1 0, 1 1, 0 1, 0 0)))"
    address "POINT (0.5 0.5)"
  end
end
