class CreateGardens < ActiveRecord::Migration[5.1]
  def change
    create_table :gardens do |t|
      t.string :zip_code
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
