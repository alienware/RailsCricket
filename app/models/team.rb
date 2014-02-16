class Team < ActiveRecord::Base
	has_and_belongs_to_many :players
	has_many :matches

	def matches_with_format format
		[Match.where(:team1_id => self.id, :format => format).pluck(:id), Match.where(:team2_id => self.id, :format => format).pluck(:id)].flatten
	end

	def top10 format, field
		total = {}
		(self.matches_with_format format).each { |match|
			match_player = MatchPlayer.find_by_match_id match
			unless self.players.include? match_player.player
				total[match_player.player.id] ||= 0
				total[match_player.player.id] += match_player.send(field)
			end
		}
		total.sort_by {|key,value| -value}.first(2).map(&:first)
	end
end
