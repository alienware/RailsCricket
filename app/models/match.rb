class Match < ActiveRecord::Base
	has_many :match_players
	has_many :players, :through => :match_players
	belongs_to :team1, :class_name => 'Team'
	belongs_to :team2, :class_name => 'Team'

	def top2 field
		total = {}
		MatchPlayer.where(:match => self).each { |match_player|
			total[match_player.player_id] = match_player.send(field)
		}

		total.sort_by {|key,value| -value}.first(2).map(&:first)
	end
end
