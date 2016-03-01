class SoundcloudController < ApplicationController
  def connect
  	# create client object with app credentials
client = Soundcloud.new(:client_id => ENV["SOUNDCLOUD_CLIENT_ID"],
                        :client_secret => ENV["SOUNDCLOUD_CLIENT_SECRET"],
                        :redirect_uri => "http://localhost:3000/soundcloud/connected",
                        :response_type => 'code')

# redirect user to authorize URL
redirect_to client.authorize_url(:grant_type => 'authorization_code', :scope => 'non-expiring', :display => 'popup') 
  end

  def connected
	  	# create client object with app credentials
	client = Soundcloud.new(:client_id => ENV["SOUNDCLOUD_CLIENT_ID"],
	                    :client_secret => ENV["SOUNDCLOUD_CLIENT_SECRET"],
	                    :redirect_uri => "http://www.aimuzer.com/soundcloud/connected")
	# exchange authorization code for access token
	access_token = client.exchange_token(:code => params[:code])
	client = Soundcloud.new(:access_token => access_token["access_token"])
	# make an authenticated call
	soundcloud_user = client.get('/me')

	@user = User.find_by(:soundcloud_user_id => soundcloud_user["id"])

	unless @user.present?
	  @user = User.create_from_soundcloud(soundcloud_user, access_token)
	end

	sign_in @user
	redirect_to user_path(@user.id)
  
	
  end

  # def new
  # 	@user = User.create_from_soundcloud(soundcloud_user, access_token)
  # 	session[:user_id] = sign_in_user.first.id
  # end

 #  def save_soundcloud_user
 #  	# save the user with an email they provide
 #  	@user.create! do |user|
 #  	user.soundcloud_user_id = soundcloud_user["id"]
 #    user.soundcloud_access_token = access_token["access_token"]
 #    user.email = params[:email]
 #    user.zipcode = params[:zipcode]
 #    user.soundcloud_username = soundcloud_user["username"]
	# end
 #  end

  def destroy
  	session[:user_id] = nil
	redirect_to root_url, notice: "Logged out!"
  end
end
