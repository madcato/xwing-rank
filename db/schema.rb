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

ActiveRecord::Schema.define(version: 20140811085452) do

  create_table "admins", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.integer  "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points1"
    t.integer  "points2"
  end

  add_index "matches", ["player1_id", "player2_id"], name: "index_matches_on_player1_id_and_player2_id"

  create_table "players", force: true do |t|
    t.string   "firstName"
    t.string   "uniqueid"
    t.integer  "numberOfMatches"
    t.integer  "ranking"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "city"
    t.string   "lastName"
  end

  add_index "players", ["firstName"], name: "index_players_on_firstName", unique: true
  add_index "players", ["ranking"], name: "index_players_on_ranking"

  create_table "players_tourneys", force: true do |t|
    t.integer  "player_id"
    t.integer  "tourney_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players_tourneys", ["tourney_id", "player_id"], name: "index_players_tourneys_on_tourney_id_and_player_id", unique: true

  create_table "rankings", force: true do |t|
    t.integer  "player_id"
    t.integer  "points",      default: 0
    t.integer  "breakpoints", default: 0
    t.integer  "sos",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tourney_id"
    t.boolean  "bye",         default: false
  end

  add_index "rankings", ["player_id", "tourney_id"], name: "index_rankings_on_player_id_and_tourney_id"
  add_index "rankings", ["points", "breakpoints", "sos"], name: "index_rankings_on_points_and_breakpoints_and_sos"

  create_table "rounds", force: true do |t|
    t.integer  "order"
    t.integer  "tourney_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rounds", ["order"], name: "index_rounds_on_order"
  add_index "rounds", ["tourney_id", "order"], name: "index_rounds_on_tourney_id_and_order", unique: true

  create_table "tourneys", force: true do |t|
    t.integer  "state"
    t.string   "titulo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.date     "playDate"
  end

  add_index "tourneys", ["titulo"], name: "index_tourneys_on_titulo", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
