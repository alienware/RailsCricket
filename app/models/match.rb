class Match < ActiveRecord::Base
	has_many :match_players
	has_many :players, :through => :match_players
	belongs_to :team1, :class_name => 'Team'
	belongs_to :team2, :class_name => 'Team'

	def top field, n, options = {}
		total = {}
		MatchPlayer.where(:match => self).each { |match_player|
			if options.empty?
				total[match_player.player.name] = match_player.send(field.to_sym)
			else
				total[match_player.player.name] = match_player.send(field.to_sym) if options[:team].players.to_a.include? match_player.player
			end
		}

		total.sort_by {|key,value| -value}.first(n)
	end
end
