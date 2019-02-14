require 'rails_helper'

RSpec.describe UserDecorator do
  it 'tells me no gardens create yet when no gardens' do
    user = create(:user)
    decorator = user.decorate
    
    expect(decorator.show_gardens).to eq("<h3>No Gardens Created Yet!</h3>")
  end
  
  it 'returns gardens when there are gardens' do
    user = create(:user)
    garden_1 = create(:garden, user: user, name: 'Garden 1', zip_code: '11111')
    garden_2 = create(:garden, user: user, name: 'Garden 2', zip_code: '11111')
    decorator = user.decorate
    
    expect(decorator.show_gardens).to be_a(String)
    expect(decorator.show_gardens).to have_content("Garden 111111\nGarden 211111")
  end
end
