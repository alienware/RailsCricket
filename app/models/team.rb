class Team < ActiveRecord::Base
	has_and_belongs_to_many :players
	has_many :matches

	def matches_with_format format
		[Match.includes(:match_players).where(:team1_id => self.id, :format => format), Match.includes(:match_players).where(:team2_id => self.id, :format => format)].flatten
	end

	def forTop10 format, field
		total = {}
		(self.matches_with_format format).each { |match|
			match.match_players.each { |match_player|
				if self.players.include? match_player.player
					total[match_player.player.id] ||= 0
					total[match_player.player.id] += match_player.send(field)
				end
			}
		}
		total.sort_by {|key,value| -value}.first(10).map(&:first)
	end

	def againstTop10 format, field
		total = {}
		(self.matches_with_format format).each { |match|
			match.match_players.each { |match_player|
				unless self.players.include? match_player.player
					total[match_player.player.id] ||= 0
					total[match_player.player.id] += match_player.send(field)
				end
			}
		}
		total.sort_by {|key,value| -value}.first(10).map(&:first)
	end
end
