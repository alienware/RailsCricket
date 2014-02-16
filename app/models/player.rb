class Player < ActiveRecord::Base
	has_and_belongs_to_many :teams
	has_many :match_players
	has_many :matches, :through => :match_players

	serialize :statistics, Hash

	def matches_with_format format
		self.matches.where(:format => format)
	end

	def self.top format, field, num
		total = {}
		Player.all.each { |player|
			total[player.name] = player.statistics[(format + '_' + field).to_sym]
		}

		total.sort_by {|key, value| -value }.first(num)
	end
end
