class AddStatisticsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :statistics, :text
  end
end
