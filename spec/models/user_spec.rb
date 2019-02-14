require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :google_token }
    it { should validate_presence_of :google_id_token }
  end

  describe 'Relationships' do
    it { should have_many(:gardens) }
  end
end
