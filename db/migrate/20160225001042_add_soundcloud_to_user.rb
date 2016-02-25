class AddSoundcloudToUser < ActiveRecord::Migration
  def change
    add_column :users, :soundcloud_user_id, :integer
    add_index :users, :soundcloud_user_id
    add_column :users, :soundcloud_access_token, :string
    add_index :users, :soundcloud_access_token
  end
end
