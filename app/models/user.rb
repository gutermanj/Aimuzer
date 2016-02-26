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
         :recoverable, :rememberable, :trackable, :validatable

         # validates :email, presence :true, if: self.soundcloud_user_id.nil?


    validates :email, uniqueness: true, if: :devise_user?
    validates :password, presence: true, if: :devise_user?
    validates :first_name, presence: true, if: :devise_user?
    validates :last_name, presence: true, if: :devise_user?
    validates :username, presence: true, if: :devise_user?
    validates :zipcode, presence: true, if: :devise_user?


  def devise_user?
    self.soundcloud_user_id.nil?
  end


  def email_required?
    if self.soundcloud_user_id.nil?
      true
    else
      false
    end
  end

  def password_required?
    if self.soundcloud_user_id.nil?
      true
    else
      false
    end
  end

  
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

  def picture
    # inside
    # self.avatar  #uploader object
    # self.avatar_url  #actual URL
    # self.sc_avatar   #actual URL

    # if file is present, assign uploaded image

    # if file is nil, and not a soundcloud user, use default image

    # if file is nil, and is soundcloud user use sc_avatar


      if self.avatar.file
        self.avatar_url

      elsif self.soundcloud_user_id.nil?
        self.avatar_url

      else
        self.sc_avatar

      end 

     # outside (FYI)
     # @user.picture
  end

  def self.create_from_soundcloud(soundcloud_user, access_token)
   create! do |user|
    user.soundcloud_user_id = soundcloud_user["id"]
    user.soundcloud_access_token = access_token["access_token"]
    user.username = soundcloud_user.username
    user.sc_avatar = soundcloud_user.avatar_url
    puts "--------------------------------------------------------"
    p soundcloud_user
    end

  end


  private

  def welcome_message
    UserMailer.welcome_message(self.devliver)
  end

end
