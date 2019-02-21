class CreateUserGardens < ActiveRecord::Migration[5.1]
  def change
    create_table :user_gardens do |t|
      t.integer :relationship_type, default: 0
  
      t.references :garden, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
