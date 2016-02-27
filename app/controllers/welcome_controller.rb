class WelcomeController < ApplicationController
  def index
	  	if params[:search]
	      @tracks = Track.search(params[:search]).order("created_at DESC")
	    else
	  	@tracks = Track.all
  		end
  end

  def search
  		if params[:search]
	    @tracks = Track.search(params[:search]).order("created_at DESC")
	    else
	  	@tracks = Track.all
  		end
  	end
end
