class TeamsController < ApplicationController

	def create
		@team = Team.new(team_params)

		respond_to do |format|
			if @team.save
				format.html { redirect_to '/', :notice => 'Team was successfully created.' }
			else
				format.html { redirect_to '/', :notice => 'Team could not be created.' }
			end
		end
	end

	def addPlayers
		@team = Team.find(params[:team][:id].to_i)
		players = Player.where("id IN (?)", params[:match][:players].map(&:to_i)).to_a
		players.each { |player|
			@team << player
		}

		respond_to do |format|
			format.html { redirect_to '/', :notice => "Players were successfully added to Team #{@team.name}." }
		end

	end

	private

	def team_params
		params[:match].permit(:name)
	end
end
