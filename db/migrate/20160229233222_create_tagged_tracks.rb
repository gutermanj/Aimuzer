class CreateTaggedTracks < ActiveRecord::Migration
  def change
    create_table :tagged_tracks do |t|
      t.integer :track_id
      t.integer :tag_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
