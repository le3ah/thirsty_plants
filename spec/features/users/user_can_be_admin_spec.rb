require 'rails_helper'

describe "User can be admin" do
  it 'can be an admin' do
    admin = create(:user, role: 1)
    expect(admin.role).to eq("admin")
    expect(admin.admin?).to be_truthy
  end

  it 'can not be an admin' do
    user = create(:user)
    expect(user.role).to eq("default")
    expect(user.admin?).to_not be_truthy
  end
end
