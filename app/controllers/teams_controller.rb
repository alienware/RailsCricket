class TeamsController < ApplicationController

	def create
		@team = Team.new(team_params)

		respond_to do |format|
			if @team.save
				format.html { redirect_to '/', :notice => 'Team was successfully created.' }
				format.json {
					render :json => { :message => "Team #{@team.name} was successfully created."}, :status => 200
				}
			else
				format.html { redirect_to '/', :notice => 'Team could not be created.' }
				format.json {
					render :json => { :message => "Team could not be created."}, :status => 400
				}
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

	def topFor
		render :json => { :top_for => Team.find(params[:team_id]).forTop(params[:format], params[:field], params[:num].to_i) }, :status => 200
	end

	def topAgainst
		render :json => { :top_for => Team.find(params[:team_id]).againstTop(params[:format], params[:field], params[:num].to_i) }, :status => 200
	end

	private

	def team_params
		params[:team].permit(:name)
	end
end
