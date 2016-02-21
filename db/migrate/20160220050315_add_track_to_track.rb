class AddTrackToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :track, :string
  end
end
