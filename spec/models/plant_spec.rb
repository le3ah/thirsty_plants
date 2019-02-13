require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :times_per_week}
  end

  describe 'Relationships' do
    it { should belong_to :garden }
  end
end
