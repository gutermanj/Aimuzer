class CreatePlaylistTracks < ActiveRecord::Migration
  def change
    create_table :playlist_tracks do |t|

      t.timestamps null: false
    end
  end
end
