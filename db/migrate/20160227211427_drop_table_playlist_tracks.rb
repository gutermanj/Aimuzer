class DropTablePlaylistTracks < ActiveRecord::Migration
  def change
  	drop_table :playlist_tracks
  end
end
