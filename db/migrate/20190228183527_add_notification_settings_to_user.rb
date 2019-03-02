class AddNotificationSettingsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :receive_emails, :boolean, default: true
    add_column :users, :receive_texts, :boolean, default: false
    add_column :users, :rainy_day_notifications, :boolean, default: false
    add_column :users, :frost_notifications, :boolean, default: false
    add_column :users, :missed_watering_notifications, :boolean, default: true
  end
end
