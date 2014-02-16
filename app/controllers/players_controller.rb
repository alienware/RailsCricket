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
		@player = Player.find(params[:player_id].to_i)
		team = Team.find(params[:team].to_i)

		team.players << @player unless team.players.include? @player

		render :json => { :message => "Player has been successfully added to team #{team.name}." }, :status => 200
	end

	def removeTeam
		@player = Player.find(params[:player_id].to_i)
		team = Team.find(params[:team].to_i)

		team.players.delete(@player)

		render :json => { :message => "Player has been successfully removed from team #{team.name}." }, :status => 200
	end

	def top
		render :json => { :top => Player.top(params[:format], params[:field], params[:num].to_i)}, :status => 200
	end

	private

	def player_params
		params[:player].permit(:name, :dob, :role)
	end
end
