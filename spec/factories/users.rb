FactoryBot.define do
  factory :user do
    first_name { "Gob" }
    last_name { "Bluth" }
    email { "gobis@bluth.com" }
    google_token { "MyString" }
    google_id { "MyString" }
  end
end
