# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Dummy players
22.times do |i|
	Player.create(:name => "Player #{i}", :dob => [*18...41].sample.years.ago, :role => ['Batsman', 'Bowler'].sample)
end

#Dummy teams
Team.create(:name => 'Team 1')
Team.create(:name => 'Team 2')

Team.first.players << Player.first(11)
Team.last.players << Player.last(11)
