class User < ApplicationRecord
  has_many :gardens
  validates_presence_of :first_name,
                        :email,
                        :google_token,
                        :google_id
  enum role: ["default", "admin"]                      

  def self.from_google_auth(auth_info)
    where(google_id: auth_info[:uid]).first_or_create do |new_user|
      new_user[:google_token]         = auth_info[:credentials][:token]
      new_user[:first_name]            = auth_info[:info][:first_name]
      new_user[:last_name]              = auth_info[:info][:last_name]
      new_user[:email]                 = auth_info[:info][:email]
      new_user[:google_id]            = auth_info[:uid]
    end
  end
end
