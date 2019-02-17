class ChangeUserGoogleIdTokenToGoogleId < ActiveRecord::Migration[5.1]
  def change
    rename_column(:users, :google_id_token, :google_id)
  end
end
