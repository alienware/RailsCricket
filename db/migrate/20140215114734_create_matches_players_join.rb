class CreateMatchesPlayersJoin < ActiveRecord::Migration
  def change
		#Join table converted to a Model; now useless

		#create_table :matches_players do |t|
		#	t.integer :match_id
		#	t.integer :player_id
		#	t.integer :runs
		#	t.integer :wickets
		#	t.integer :catches
		#	t.integer :stumps
		#end
		#add_index :matches_players, :match_id
		#add_index :matches_players, :player_id
  end
end
