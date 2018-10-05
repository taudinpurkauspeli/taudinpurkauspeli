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

ActiveRecord::Schema.define(version: 2018_10_05_122159) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "asked_questions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checked_hypotheses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "exercise_hypothesis_id"
  end

  create_table "completed_exercises", force: :cascade do |t|
    t.integer "user_id"
    t.integer "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "completed_subtasks", force: :cascade do |t|
    t.integer "subtask_id"
    t.integer "user_id"
  end

  create_table "completed_tasks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conclusions", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.integer "subtask_id"
    t.integer "exercise_hypothesis_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercise_hypotheses", force: :cascade do |t|
    t.integer "exercise_id"
    t.integer "hypothesis_id"
    t.integer "task_id"
    t.string "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.boolean "hidden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "anamnesis"
  end

  create_table "hypotheses", force: :cascade do |t|
    t.string "name"
    t.integer "count"
    t.integer "hypothesis_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hypothesis_groups", force: :cascade do |t|
    t.string "name"
  end

  create_table "interviews", force: :cascade do |t|
    t.string "title"
    t.integer "subtask_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "log_entries", force: :cascade do |t|
    t.integer "user_id"
    t.string "controller"
    t.string "action"
    t.text "params"
    t.integer "exercise_id"
    t.integer "task_id"
    t.text "exhyp_ids"
    t.datetime "datetime"
    t.string "request_path"
    t.string "ip"
    t.string "method"
    t.string "response_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "flash_notice"
    t.string "flash_alert"
  end

  create_table "multichoices", force: :cascade do |t|
    t.string "question"
    t.integer "subtask_id"
    t.boolean "is_radio_button"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.integer "multichoice_id"
    t.string "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "is_correct_answer", default: 0
    t.integer "title_id"
  end

  create_table "own_files", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_groups", force: :cascade do |t|
    t.string "title"
    t.integer "interview_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.integer "question_group_id"
    t.integer "interview_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "required", default: 0
    t.integer "title_id"
  end

  create_table "subtasks", force: :cascade do |t|
    t.integer "task_id"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_texts", force: :cascade do |t|
    t.string "content"
    t.integer "subtask_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.integer "exercise_id"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "titles", force: :cascade do |t|
    t.string "text"
    t.integer "bank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "student_number"
    t.integer "starting_year"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "tester", default: false
    t.boolean "accept_academic_research", default: false
    t.boolean "accept_licence_agreement", default: false
    t.boolean "accept_academic_use", default: false
  end

end
