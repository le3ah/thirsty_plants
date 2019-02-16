require 'rails_helper'

RSpec.describe Zipcode, type: :model do
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
end
