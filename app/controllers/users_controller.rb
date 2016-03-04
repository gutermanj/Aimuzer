class UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token

  	def show
  		@user = User.find_by(id: params[:id])
  		@tag = Tag.find_by(id: params[:id])
  		


  		@zipcode = ZipCodes.identify(@user.zipcode.to_s)
  		@followers = @user.followers.all

  		@randtags = rand(100)

  		@randfollowers = rand(1000)

  		@track = Track.find_by(id: params[:id])

  		@tracks = @user.tracks.all

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

	def add_tag
		@user = current_user
		@tag = Tag.find_by(id: params[:id])
		@users_tag = @user.user_tags.find_by(tag_id: @tag.id)

		if @users_tag.nil?
			@last_tag = @user.user_tags.create(
							:user_id => @user.id,
							:tag => @tag
							)

			render json: @last_tag

		else
			puts "=========================="
			puts @users_user_tag

			@users_tag.increment(:weight)
			@users_tag.save

		end

			render json: @users_user_tag
		

	end

	private

	# Use strong_parameters for attribute whitelisting
	# Be sure to update your create() and update() controller methods.

	def user_params
	  params.require(:user).permit(:avatar)
	end

end


