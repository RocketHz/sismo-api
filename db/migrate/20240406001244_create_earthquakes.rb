class CreateEarthquakes < ActiveRecord::Migration[6.1]
  def change
    create_table :earthquakes do |t|
      t.decimal :mag
      t.string :place
      t.datetime :time
      t.string :url
      t.boolean :tsunami
      t.string :mag_type
      t.string :title
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
