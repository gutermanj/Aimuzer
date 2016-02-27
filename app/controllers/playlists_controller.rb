class PlaylistsController < ApplicationController
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
		else
			redirect_to :back
		end

	 end

	 private

	 def playlist_params
	 	params.require(:playlist).permit(:name)
	 end

end
