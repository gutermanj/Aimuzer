class Track < ActiveRecord::Base
	acts_as_votable
	belongs_to :user

	mount_uploader :track, TrackUploader

	validates :title, presence: true
	validates :description, presence: true
	validates :track, presence: true
	validates_length_of :title, :minimum => 2, :too_short => "please enter at least %d character"
	validates_length_of :description, :minimum => 10, :too_short => "please enter at least %d characters"
end
