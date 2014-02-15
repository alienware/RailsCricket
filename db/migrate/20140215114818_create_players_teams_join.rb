class CreatePlayersTeamsJoin < ActiveRecord::Migration
  def change
    create_table :players_teams do |t|
			t.integer :player_id
			t.integer :team_id
		end
		add_index :players_teams, :player_id
		add_index :players_teams, :team_id
  end
end
