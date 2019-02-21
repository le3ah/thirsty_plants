class RemoveUserId < ActiveRecord::Migration[5.1]
  def change
    remove_index :gardens, :user_id
    remove_column :gardens, :user_id
  end
end
