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
		@team = Team.find(params[:team_id].to_i)
		players = Player.where("id IN (?)", params[:team][:players].to_a.map(&:to_i)).to_a
		players.each { |player|
			@team.players << player unless @team.players.include? player
		}

		render :json => { :message => "Players were successfully added to team #{@team.name}." }, :status => 200
	end

	def removePlayers
		@team = Team.find(params[:team_id].to_i)
		players = Player.where("id IN (?)", params[:team][:players].to_a.map(&:to_i)).to_a
		players.each { |player|
			@team.players.delete(player)
		}

		render :json => { :message => "Players were successfully removed from team #{@team.name}." }, :status => 200
	end

	private

	def team_params
		params[:team].permit(:name)
	end
end
