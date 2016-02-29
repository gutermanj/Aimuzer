class PlaylistsController < ApplicationController

	def index
		@user = User.find_by(id: params[:user_id])
		render 'index'
	end

	def new
		@user = current_user
		@playlist = @user.playlists.new

		render 'new'
	end

	 def create
		@user = current_user

		@playlist = @user.playlists.create(playlist_params)

		if @playlist.save
			redirect_to user_path(current_user)
			flash[:notice] = 'Playlist successfully created!'
		else
			redirect_to :back
		end

	 end

	 def show
	 	render 'show'
	 end

	 private

	 def playlist_params
	 	params.require(:playlist).permit(:name)
	 end

end
