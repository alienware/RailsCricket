module MatchesHelper


	#randonStatisticsGenerator allocated runs scored and wickets fallen when 2 teams face each other
	#Runs are at random between 50 and 299 and wicket tally is team 0 to number of players in opposition

	def randomStatisticsGenerator team1, team2 #TODO: logic is not perfect, number of players scoring != number of wickets+2
		runs_scored_by_team1 = [*50...300].sample
		wickets_taken_by_team1 = [*0...team2.players.count].sample

		runs_scored_by_team2 = [*50...300].sample
		wickets_taken_by_team2 = [*0...team1.players.count].sample
		[runs_scored_by_team1, wickets_taken_by_team1, runs_scored_by_team2, wickets_taken_by_team2]
	end

	#The following method allocated runs and wickets of a team to individual players
	#Players for each sides are picked and supplied to this method
	#As player is allocated runs/wickets, that amount is depleted from team's total and added to player's statistics and match-player's scorecard
	#The indexes for statistics array as manipulated using team_index (0/1) and players_index(0...11) to assign correct runs/wickets
	#Last player in a team is allocated remaining runs to be scored/wickets taken by his team

	def addMatchPlayers player, player_index, team, team_index	#players_index is used to assign remaining statistics to last player and team_index is used to decide which statistics is to be used
		match_player = MatchPlayer.create(:match => @match, :player => player)

		if player_index.eql? team.players.count
			player.statistics[(@match.format + '_runs').to_sym] = @statistics[team_index*2]
			player.statistics[(@match.format + '_wickets').to_sym] = @statistics[1 + (team_index-1)*2]

			match_player.runs = @statistics[team_index*2]
			match_player.wickets = @statistics[1 + (team_index-1)*2]
		else
			runs_scored = [*0...(@statistics[team_index*2 ]) + 1].sample #adding 1 to ensure closed interval on statistics for [*0...0].sample returns nil
			@statistics[team_index*2] -= runs_scored

			wickets_taken = [*0...(@statistics[1 + (team_index-1)*2]) + 1].sample #adding 1 to ensure closed interval on statistics for [*0...0].sample returns nil
			@statistics[1 + (team_index-1)*2] -= wickets_taken

			player.statistics[(@match.format + '_runs').to_sym] = runs_scored
			player.statistics[(@match.format + '_wickets').to_sym] = wickets_taken

			match_player.runs = runs_scored
			match_player.wickets = wickets_taken
		end
		match_player.save
		player.save
	end
end
