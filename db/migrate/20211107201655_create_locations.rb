class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :location_title
      t.integer :street_number
      t.string :locality
      t.integer :postal_code
      t.string :latitude
      t.string :longitude
      t.string :place_id
      t.string :country
      t.string :facility_name    
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :locations, [:user_id, :created_at]
    
  end
end
