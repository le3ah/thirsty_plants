require 'rails_helper'

describe User do
  it "exists" do
    attributes = {}
    user = User.new(attributes)
    expect(user).to be_a(User)
  end
  it "has attributes" do
    attributes = { first_name: "Kathy",
                   last_name: "Miller",
                   email: "mom@gmail.com",
                   google_token: "itsastring",
                   google_id_token: "itsalsoastring"}
    user = User.new(attributes)
    expect(user.first_name).to eq("Kathy")
    expect(user.last_name).to eq("Miller")
    expect(user.email).to eq("mom@gmail.com")
    expect(user.google_token).to eq("itsastring")
    expect(user.google_id_token).to eq("itsalsoastring")

  end
end
