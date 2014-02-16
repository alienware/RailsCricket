module MatchesHelper

	def randomStatisticsGenerator team1, team2 #TODO: logic is fixed to a better logic, still a bug with team2 run scoring
		runs_scored_by_team1 = [*50...300].sample
		wickets_taken_by_team1 = [*0...team2.players.count].sample

		runs_scored_by_team2 = [*50...300].sample
		wickets_taken_by_team2 = [*0...team1.players.count].sample
		[runs_scored_by_team1, wickets_taken_by_team1, runs_scored_by_team2, wickets_taken_by_team2]
	end

	def addMatchPlayers player, player_index, team, team_index	#players_index is used to assign remaining statistics to last player and team_index is used to decide which statistics is to be used
		match_player = MatchPlayer.create(:match => @match, :player => player)

		case player_index

			when team.players.count - 1
				player.statistics[(@match.format + '_wickets').to_sym] = @statistics[1 + (team_index)*2]
				match_player.wickets = @statistics[1 + (team_index)*2]
				@statistics[1 + (team_index)*2] = 0

				player.statistics[(@match.format + '_runs').to_sym] = @statistics[team_index*2]
				match_player.runs = @statistics[team_index*2]
				@statistics[team_index*2] = 0

			when @statistics[3 - 2*team_index] + 1
				wickets_taken = [*0...(@statistics[1 + (team_index)*2]) + 1].sample #adding 1 to ensure closed interval on statistics for [*0...0].sample returns nil
				@statistics[1 + (team_index)*2] -= wickets_taken
				player.statistics[(@match.format + '_wickets').to_sym] = wickets_taken
				match_player.wickets = wickets_taken

				player.statistics[(@match.format + '_runs').to_sym] = @statistics[team_index*2]
				match_player.runs = @statistics[team_index*2]
				@statistics[team_index*2] = 0

			else
				runs_scored = [*0...(@statistics[team_index*2]) + 1].sample #adding 1 to ensure closed interval on statistics for [*0...0].sample returns nil
				@statistics[team_index*2] -= runs_scored

				wickets_taken = [*0...(@statistics[1 + (team_index)*2]) + 1].sample #adding 1 to ensure closed interval on statistics for [*0...0].sample returns nil
				@statistics[1 + (team_index)*2] -= wickets_taken

				player.statistics[(@match.format + '_runs').to_sym] = runs_scored
				player.statistics[(@match.format + '_wickets').to_sym] = wickets_taken

				match_player.runs = runs_scored
				match_player.wickets = wickets_taken
		end

		match_player.save
		player.save
	end
end
