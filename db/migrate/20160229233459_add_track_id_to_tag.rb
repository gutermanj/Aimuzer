class AddTrackIdToTag < ActiveRecord::Migration
  def change
    add_column :tags, :track_id, :integer
  end
end
