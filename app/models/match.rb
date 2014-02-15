class Match < ActiveRecord::Base
	has_many :match_players
	has_many :players, :through => :match_players
	belongs_to :team1, :class_name => 'Team'
	belongs_to :team2, :class_name => 'Team'

	def top10 format, field
		total = {}
		Player.all.each { |player|
			player.matches_with_format(format).each { |match|
				total[player] += match.send(field)
			}
		}

		total.sort_by {|key,value| -value}.first(10).map(&:first).flatten
	end
end
