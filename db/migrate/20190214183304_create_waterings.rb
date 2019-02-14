class CreateWaterings < ActiveRecord::Migration[5.1]
  def change
    create_table :waterings do |t|
      t.datetime :watertime
      t.boolean :completed, default: false
      t.references :plant, foreign_key: true

      t.timestamps
    end
  end
end
