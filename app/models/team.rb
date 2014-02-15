class Team < ActiveRecord::Base
	has_and_belongs_to_many :players
	has_many :matches

	#def top10 statistics_field, format
	#	self.matches.format_is(format).
	#end
end
