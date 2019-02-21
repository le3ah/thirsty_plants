require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :google_token }
    it { should validate_presence_of :google_id }
  end

  describe 'Relationships' do
    it { should have_many(:gardens) }
  end
  
  describe 'Instance Methods' do
    describe '#own_gardens' do
      it 'should return the gardens for which the user is the owner' do
        owner = create(:user)
        garden_1 = create(:garden, owners: [owner])
        garden_2 = create(:garden, owners: [owner])
        not_owner = create(:user)
        garden_3 = create(:garden, owners: [not_owner])
        create(:user_garden, garden: garden_3, user: owner, relationship_type: 'caretaker')
        
        expect(owner.own_gardens).to eq([garden_1, garden_2])
        expect(not_owner.own_gardens).to eq([garden_3])
      end
    end
    describe '#caretaking_gardens' do
      it 'should return the gardens for which the user is the caretaker' do
        owner = create(:user)
        garden_1 = create(:garden, owners: [owner])
        garden_2 = create(:garden, owners: [owner])
        not_owner = create(:user)
        garden_3 = create(:garden, owners: [not_owner])
        create(:user_garden, garden: garden_3, user: owner, relationship_type: 'caretaker')
        
        expect(owner.caretaking_gardens).to eq([garden_3])
        expect(not_owner.caretaking_gardens).to eq([])
      end
    end
  end
end
