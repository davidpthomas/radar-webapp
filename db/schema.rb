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

ActiveRecord::Schema.define(version: 20150922191909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rally_enum_caches", force: :cascade do |t|
    t.string   "artifact_type"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "job_id"
    t.string   "ref"
  end

  create_table "rally_oid_caches", force: :cascade do |t|
    t.integer  "oid"
    t.string   "name"
    t.string   "artifact_type"
    t.integer  "job_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "ref"
  end

  add_index "rally_oid_caches", ["job_id"], name: "index_rally_oid_caches_on_job_id", using: :btree

  add_foreign_key "rally_oid_caches", "jobs"
end
