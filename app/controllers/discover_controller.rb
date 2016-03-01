class DiscoverController < ApplicationController
  def index

  	if current_user
  		redirect_to stream_path
  	end

  end

  def stream
  	@tracks = Track.all


  end

end
