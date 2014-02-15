class Player < ActiveRecord::Base
	has_and_belongs_to_many :teams
	has_many :match_players
	has_many :matches, :through => :match_players

	serialize :statistics, Hash

	def matches_with_format format
		self.matches.where(:format => format)
	end

	def top10 format
		total = {}
		Player.all.each { |player|
			total[player] = player.statistics[format]
		}

		total.sort_by {|key, value| -value }.first(10).map(&:first).flatten
	end
end
