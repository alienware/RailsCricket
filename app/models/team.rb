class Team < ActiveRecord::Base
	has_and_belongs_to_many :players
	has_many :matches

	def matches_with_format format
		[Match.includes(:match_players).where(:team1_id => self.id, :format => format), Match.includes(:match_players).where(:team2_id => self.id, :format => format)].flatten
	end

	def forTop format, field, num	#TODO: optimize queries
		total = {}
		(self.matches_with_format format).each { |match|
			match.match_players.each { |match_player|
				if self.players.include? match_player.player
					total[match_player.player.name] = 0 if total[match_player.player.name].nil?
					total[match_player.player.name] += match_player.send(field.to_sym)
				end
			}
		}
		total.sort_by {|key,value| -value}.first(num)
	end

	def againstTop format, field, num
		total = {}
		(self.matches_with_format format).each { |match|
			match.match_players.each { |match_player|
				unless self.players.include? match_player.player
					total[match_player.player.name] = 0 if total[match_player.player.name].nil?
					total[match_player.player.name] += match_player.send(field.to_sym)
				end
			}
		}
		total.sort_by {|key,value| -value}.first(num)
	end
end
