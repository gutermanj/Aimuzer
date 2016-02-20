class UsersController < ApplicationController

  	def show
  		@user = User.find(params[:id])
  		@zipcode = ZipCodes.identify(@user.zipcode.to_s)

  		@randtags = rand(100)

  		@randfollowers = rand(1000)

	end

	def new
	end

	def create
	  @user = User.create( user_params )
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


