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

ActiveRecord::Schema.define(version: 2018_07_09_031406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "stores", force: :cascade do |t|
    t.text "name", null: false
    t.text "owner", null: false
    t.text "document", null: false
    t.geometry "coverage_area", limit: {:srid=>0, :type=>"multi_polygon"}, null: false
    t.geometry "address", limit: {:srid=>0, :type=>"st_point"}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_stores_on_address", using: :gist
    t.index ["coverage_area"], name: "index_stores_on_coverage_area", using: :gist
  end

end
