class DiscoverController < ApplicationController
  def index

  	if current_user
  		redirect_to stream_path
  	end

  end

  def stream
  	ids = []
  	current_user.tags.each do |x|
  		ids.push(Tag.where("characteristic iLIKE ?", "%" + x.characteristic + "%").map(&:id))
  	end
  		puts '------------------------------'
  		puts ids
  		puts '------------------------------'
  		@tracks = TaggedTrack.joins(:track).where(tag_id: ids.flatten).map(&:track).uniq
  		# @tracks = Track.joins(:tagged_tracks).where(tagged_tracks: { tag_id: ids })
  end

end
