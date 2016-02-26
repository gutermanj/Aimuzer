class AddSoundcloudAvatarToUser < ActiveRecord::Migration
  def change
    add_column :users, :sc_avatar, :string
  end
end
