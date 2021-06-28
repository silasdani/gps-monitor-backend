class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.datetime :date
      t.float :distance
      t.integer :time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tracks, [:user_id, :created_at]
  end
end
