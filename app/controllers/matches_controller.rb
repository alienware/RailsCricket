class MatchesController < ApplicationController

	def new
		@match = Match.new
	end

	def randomStatisticsGenerator team1, team2

	end

	def addPlayers players
		@match.players << players
	end

	def create
		@match = Match.create(params[:match])
		team1 = Team.find(params[:match][:team1].to_i)
		team2 = Team.find(params[:match][:team2].to_i)
		players = []

		runs_scored_by_team1 = [*50...300].sample
		wickets_taken_by_team1 = [*0...team2.players.count]

		runs_scored_by_team2 = [*50...3000].sample
		wickets_taken_by_team2 = [*0...team1.players.count]

		Team.find(params[:match][:team1].to_i).players.each_with_index { |player, i|
			@match.players << player

			if i.eql? team1.players.count
				player.statistics[@match.format] = runs_scored_by_team1

			end
			runs_scored = [*0...runs_scored_by_team1].sample
			runs_scored_by_team1 -= runs_scored
			player.statistics[@match.format] = runs_scored

		}
	end
end
