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

ActiveRecord::Schema.define(version: 20150210141210) do

  create_table "exercise_hypotheses", force: :cascade do |t|
    t.integer  "exercise_id"
    t.integer  "hypothesis_id"
    t.string   "explanation"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "anamnesis"
  end

  create_table "hypotheses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "count"
    t.integer  "hypothesis_group_id"
  end

  create_table "hypothesis_groups", force: :cascade do |t|
    t.string "name"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "exercise_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
    t.string   "email"
    t.string   "realname"
    t.string   "password_digest"
  end

end
