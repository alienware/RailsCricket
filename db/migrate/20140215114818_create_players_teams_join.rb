class CreatePlayersTeamsJoin < ActiveRecord::Migration
  def change
    create_table :players_teams_joins do |t|
			t.integer :player_id
			t.integer :team_id
		end
		add_index :players_teams_joins, :player_id
		add_index :players_teams_joins, :team_id
  end
end
