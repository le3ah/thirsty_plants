class User < ApplicationRecord
  def self.from_google_auth(auth_info)
    where(google_id_token: auth_info[:extra][:id_token]).first_or_create do |new_user|
      # binding.pry
      new_user.google_token           = auth_info.credentials.token
      new_user.first_name             = auth_info.info.first_name
      new_user.last_name              = auth_info.info.last_name
      new_user.email                  = auth_info.info.email
      new_user.google_id_token        = auth_info.extra.id_token
    end
  end
end
