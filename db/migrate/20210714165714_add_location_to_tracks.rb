class AddLocationToTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :tracks, :location, :string
  end
end
