class MatchesController < ApplicationController
	include MatchesHelper

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
			#format.html { redirect_to '/', notice: 'Match was successfully created.' }
			render :json => { :message => 'Match has finished. Statistics have been updated. '}, :status => 200
		else
			#Handle gracefully new match creation; displaying notice to view
			#format.html { redirect_to '/', notice: 'Match could not be created.' }
			render :json => { :message => 'Match cannot be finished. '}, :status => 400
		end

	end

	def top
		if match = Match.find_by_id(params[:match_id])
			team = Team.find_by_id(params[:team_id].to_i)
			if team
				render :json => { :top => match.top(params[:field], params[:num].to_i, { :team => Team.find(params[:team_id].to_i) }).to_json }, :status => 200
			else
				render :json => { :top => match.top(params[:field], params[:num].to_i).to_json }, :status => 200
			end

		else
			render :json => { :error => "Match #{params[:match_id] } does not exist." }, :status => 422
		end

	end
end
