class AddAvSpeedToTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :tracks, :av_speed, :float, default: 0.0
  end
end
