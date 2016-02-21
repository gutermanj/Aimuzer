class TracksController < ApplicationController

	def show
	end

	def new
		@user = User.find(params[:user_id])
		@track = Track.new
	end

	def create
		@user = current_user
		@track = @user.tracks.create(track_params)

		if @track.save
			redirect_to root_path
		else
			redirect_to :back
			flash[:alert] = 'There was an error processing your request'
		end
	end

	private

	def track_params
	  params.require(:track).permit(:track, :user_id, :title, :description)
	end

end
