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
	                    :redirect_uri => "http://localhost:3000/soundcloud/connected")
	# exchange authorization code for access token
	access_token = client.exchange_token(:code => params[:code])
	client = Soundcloud.new(:access_token => access_token["access_token"])
	# make an authenticated call
	soundcloud_user = client.get('/me')
	unless User.where(:soundcloud_user_id => soundcloud_user["id"]).present?
	  User.create_from_soundcloud(soundcloud_user, access_token)
	end
	sign_in_user = User.where(:soundcloud_user_id => soundcloud_user["id"])
	#create user sessions
	session[:user_id] = sign_in_user.first.id
	redirect_to root_url, notice: "Signed in!"
  end

  def destroy
  	session[:user_id] = nil
	redirect_to root_url, notice: "Logged out!"
  end
end
