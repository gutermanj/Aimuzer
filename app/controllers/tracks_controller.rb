class TracksController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	def show
		@track = Track.find_by(id: params[:id])
	end

	def new
		@user = User.find(params[:user_id])
		@track = Track.new
	end

	def create
		@user = current_user
		@track = @user.tracks.create(track_params)

		if @track.save
			redirect_to user_path(current_user)
		else
			redirect_to :back
			flash[:alert] = 'There was an error processing your request'
		end
	end

	def upvote 
	  @track = Track.find_by(id: params[:id])
	  @track.upvote_by current_user
	  
	  render json: @track
	end  

	def unvote
	  @track = Track.find_by(id: params[:id])
	  @track.unliked_by current_user

	  render json: @track
	end

	def likes
		@user = User.find_by(id: params[:id])
		@likes = @user.find_voted_items

		render json: @likes
	end



	private

	def track_params
	  params.require(:track).permit(:track, :user_id, :title, :description, :artist)
	end

end
