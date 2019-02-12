require 'rails_helper'

RSpec.describe Garden, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:name) }
  end

  describe 'Relationships' do
    it { should belong_to(:user) }
  end
end
