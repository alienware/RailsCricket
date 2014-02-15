class CreateMatchesPlayersJoin < ActiveRecord::Migration
  def change
    create_table :matches_players_joins do |t|
			t.integer :match_id
			t.integer :player_id
			t.integer :runs
			t.integer :wickets
			t.integer :catches
			t.integer :stumps
		end
		add_index :matches_players_joins, :match_id
		add_index :matches_players_joins, :player_id
  end
end
