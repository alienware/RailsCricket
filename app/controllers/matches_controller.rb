class MatchesController < ApplicationController
	include MatchesHelper
	skip_before_filter :verify_authenticity_token	#temporary patch for curl testing

	def new
		@match = Match.new
	end

	def create
		team1 = Team.find(params[:match][:team1].to_i)
		team2 = Team.find(params[:match][:team2].to_i)

		@match = Match.new(:team1 => team1, :team2 => team2, :format => params[:match][:format])

		@statistics = randomStatisticsGenerator team1, team2

		if @match.save
			[team1, team2].each_with_index { |team, x|
				team.players.each_with_index { |player, y|
					addMatchPlayers player, y, team, x
				}
			}

		else
			#Handle gracefully new match creation; displaying notice to view
		end

	end
end
