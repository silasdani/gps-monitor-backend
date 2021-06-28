class CreateRaces < ActiveRecord::Migration[6.1]
  def change
    create_table :races do |t|
      t.datetime :date
      t.float :distance
      t.integer :time # seconds

      t.timestamps
    end
  end
end
