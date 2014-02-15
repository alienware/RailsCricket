class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
			t.string :name
			t.datetime :dob
			t.string :role
      t.timestamps
    end
  end
end
