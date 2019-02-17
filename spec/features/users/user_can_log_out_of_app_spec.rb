require 'rails_helper' 

describe 'As a logged in user on the site' do
  it 'can log out of the site' do
    stub_omniauth
    
    visit root_path
    click_link 'Sign in with Google'
    user = User.last
    
    save_and_open_page
    expect(current_path).to eq(dashboard_path)
    click_link 'Sign Out' 
    
    expect(current_path).to eq(root_path)
    expect(page).to have_link("Sign in with Google")
  end
end