class DiscoverController < ApplicationController
  def index

  	if current_user
  		redirect_to stream_path
  	end

  end

  def stream
  	@tracks = Track.joins(:tagged_tracks).where(tagged_tracks: { tag_id: current_user.tags })
  end

end
