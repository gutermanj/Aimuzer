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

	def upvote 
	  @track = Track.find_by(id: params[:id])
	  @track.upvote_by current_user
	  redirect_to :back
	end  

	def unvote
	  @track = Track.find_by(id: params[:id])
	  @track.unliked_by current_user
	  redirect_to :back
	end

	def likes
		@user = User.find_by(id: params[:id])
		@likes = @user.find_voted_items

		render json: @likes
	end



	private

	def track_params
	  params.require(:track).permit(:track, :user_id, :title, :description)
	end

end
