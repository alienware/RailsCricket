class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
			t.integer 'team1_id'.to_sym
			t.integer 'team2_id'.to_sym
			t.string :format
      t.timestamps
    end
  end
end
