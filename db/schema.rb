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

ActiveRecord::Schema.define(version: 20150415114959) do

  create_table "asked_questions", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "question_id"
  end

  create_table "checked_hypotheses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "exercise_hypothesis_id"
  end

  create_table "completed_subtasks", force: :cascade do |t|
    t.integer "subtask_id"
    t.integer "user_id"
  end

  create_table "completed_tasks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conclusions", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "subtask_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercise_hypotheses", force: :cascade do |t|
    t.integer  "exercise_id"
    t.integer  "hypothesis_id"
    t.string   "explanation"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "task_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "anamnesis"
    t.boolean  "hidden"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "image_id"
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

  create_table "images", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "name"
  end

  create_table "interviews", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "subtask_id"
  end

  create_table "multichoices", force: :cascade do |t|
    t.string   "question"
    t.integer  "subtask_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "is_radio_button"
  end

  create_table "options", force: :cascade do |t|
    t.integer  "multichoice_id"
    t.string   "content"
    t.string   "explanation"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "is_correct_answer", default: 0
    t.integer  "image_id"
  end

  create_table "question_groups", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "interview_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.boolean  "required"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "question_group_id"
    t.integer  "interview_id"
    t.integer  "image_id"
  end

  create_table "subtasks", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_texts", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "subtask_id"
    t.integer  "image_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "exercise_id"
    t.integer  "level"
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
