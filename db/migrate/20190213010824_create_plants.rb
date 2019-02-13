class CreatePlants < ActiveRecord::Migration[5.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.float :times_per_week
      t.references :garden, foreign_key: true

      t.timestamps
    end
  end
end
