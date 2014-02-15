# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Dummy players
Player.create(:name => 'Player 1', :dob => 20.years.ago, :role => 'Batsman')
Player.create(:name => 'Player 2', :dob => 22.years.ago, :role => 'Bowler')
Player.create(:name => 'Player 3', :dob => 25.years.ago, :role => 'Batsman')
Player.create(:name => 'Player 4', :dob => 28.years.ago, :role => 'Bowler')

#Dummy teams
Team.create(:name => 'Team 1')
Team.create(:name => 'Team 2')

Team.first.players << Player.first(2)
Team.last.players << Player.last(2)
