class CreateZipcodes < ActiveRecord::Migration[5.1]
  def change
    create_table :zipcodes do |t|
      t.string :zip_code
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
