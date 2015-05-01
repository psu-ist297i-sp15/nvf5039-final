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

ActiveRecord::Schema.define(version: 20150501021817) do

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "riotID"
    t.string   "name"
    t.integer  "k"
    t.integer  "d"
    t.integer  "a"
    t.integer  "cs"
    t.integer  "triple"
    t.integer  "quadra"
    t.integer  "penta"
    t.integer  "towers"
    t.integer  "inhibs"
    t.integer  "dragon"
    t.integer  "baron"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
