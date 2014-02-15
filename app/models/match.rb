class Match < ActiveRecord::Base
	has_and_belongs_to_many :players
	belongs_to :team1, :class_name => 'Team'
	belongs_to :team2, :class_name => 'Team'
end
