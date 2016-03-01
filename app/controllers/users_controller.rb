class UsersController < ApplicationController

  	def show
  		@user = User.find_by(id: params[:id])
  		@zipcode = ZipCodes.identify(@user.zipcode.to_s)
  		@followers = @user.followers.all

  		@randtags = rand(100)

  		@randfollowers = rand(1000)

  		@track = Track.find_by(id: params[:id])

  		@tracks = @user.tracks

  		@data_id = 0

	end

	def new
	end

	def create
	  @user = User.create( user_params )
	end

	def followers
		@user = User.find_by(id: params[:id])
		@followers = @user.followers.all

		render json: @followers
	end

	def following
		@user = User.find_by(id: params[:id])
		@following = @user.following.all

		render json: @following
	end

	def destroy
		@user.avatar = nil
		@user.save
	end

	private

	# Use strong_parameters for attribute whitelisting
	# Be sure to update your create() and update() controller methods.

	def user_params
	  params.require(:user).permit(:avatar)
	end

end


