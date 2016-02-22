class WelcomeController < ApplicationController
  def index
  	@tracks = Track.all
  end
end
