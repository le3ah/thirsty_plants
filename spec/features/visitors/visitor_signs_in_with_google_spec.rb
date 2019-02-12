require 'rails_helper'

describe 'as a visitor' do
  it "should click sign in and be logged in with google oauth" do
    stub_omniauth

    visit root_path
    expect(page).to have_link("Sign in with Google")

    click_link "Sign in with Google"
    expect(page).to have_content("Welcome")
    # expect(page).to have_link("Logout")
  end
end
