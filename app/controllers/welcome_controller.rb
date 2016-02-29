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
	    @users = User.search(params[:search]).order("created_at DESC")
	    @track_query = @tracks.paginate(:page => params[:page], :per_page => 5)
	    @user_query = @users.paginate(:page => params[:page], :per_page => 5)
	    else
	  	@tracks = Track.all
  		end
  		
  	end
end
