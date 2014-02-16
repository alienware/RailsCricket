class PlayersController < ApplicationController

	def create
		@player = Player.new(player_params)

		respond_to do |format|
			if @player.save
				format.html { redirect_to '/', :notice => 'Player was successfully created.' }
			else
				format.html { redirect_to '/', :notice => 'Player could not be created.' }
			end
		end
	end

	def addTeam
		@player = Player.find(params[:player][:id].to_i)
		team = Team.find(params[:player][:team].to_i)

		team << @player

		respond_to do |format|
			format.html { redirect_to '/', :notice => "Player #{@player.name} were successfully added to Team #{team.name}." }
		end
	end

	private

	def player_params
		params[:players].permit(:name, :dob, :role)
	end
end
