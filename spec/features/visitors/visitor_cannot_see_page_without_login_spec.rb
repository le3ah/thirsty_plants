require 'rails_helper'

describe 'as a visitor' do
  it "should not be able to see webpages if not logged in" do
    visit dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

  end
end
