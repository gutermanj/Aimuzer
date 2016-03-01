class AddTagAndWeightToUserTags < ActiveRecord::Migration
  def change
    add_column :user_tags, :tag, :string
    add_column :user_tags, :weight, :integer
  end
end
