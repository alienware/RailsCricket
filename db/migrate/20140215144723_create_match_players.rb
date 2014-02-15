class CreateMatchPlayers < ActiveRecord::Migration
  def change
    create_table :match_players do |t|
			t.integer :match_id
			t.integer :player_id
			t.integer :runs
			t.integer :wickets
			t.integer :catches
			t.integer :stumps
		end
		add_index :match_players, :match_id
		add_index :match_players, :player_id
	end
end
