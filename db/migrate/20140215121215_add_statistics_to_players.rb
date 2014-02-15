class AddStatisticsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :statistics, :text, :default => {'odi_runs'.to_sym => 0, 'test_runs'.to_sym => 0, 'odi_wickets'.to_sym => 0, 'test_wickets'.to_sym => 0}
  end
end
