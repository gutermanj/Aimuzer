class Tag < ActiveRecord::Base
	has_many :tracks, through: :tagged_tracks

	has_many :users, through: :user_tag
end
