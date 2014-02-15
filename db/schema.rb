# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140215121215) do

  create_table "matches", force: true do |t|
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.string   "format"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches_players_joins", force: true do |t|
    t.integer "match_id"
    t.integer "player_id"
    t.integer "runs"
    t.integer "wickets"
    t.integer "catches"
    t.integer "stumps"
  end

  add_index "matches_players_joins", ["match_id"], name: "index_matches_players_joins_on_match_id", using: :btree
  add_index "matches_players_joins", ["player_id"], name: "index_matches_players_joins_on_player_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "dob"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "statistics"
  end

  create_table "players_teams_joins", force: true do |t|
    t.integer "player_id"
    t.integer "team_id"
  end

  add_index "players_teams_joins", ["player_id"], name: "index_players_teams_joins_on_player_id", using: :btree
  add_index "players_teams_joins", ["team_id"], name: "index_players_teams_joins_on_team_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
