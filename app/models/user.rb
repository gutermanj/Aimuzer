class User < ActiveRecord::Base
  require 'soundcloud'
  acts_as_voter
  belongs_to :gallery

  has_many :tracks

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy                                

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  mount_uploader :avatar, AvatarUploader

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def self.create_from_soundcloud(soundcloud_user, access_token)

  create! do |user|
    user.soundcloud_user_id = soundcloud_user["id"]
    user.soundcloud_access_token = access_token["access_token"]
  end
  
end

  



end
