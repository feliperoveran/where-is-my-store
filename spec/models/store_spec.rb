require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :owner }
  it { should validate_presence_of :document }
  it { should validate_presence_of :coverage_area }
  it { should validate_presence_of :address }
end
