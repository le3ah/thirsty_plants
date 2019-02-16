require 'rails_helper'

RSpec.describe Watering, type: :model do
  describe 'relationships' do
    it { should belong_to :plant}
  end
  describe 'validations' do
    it { should validate_presence_of :water_time }
  end
end
