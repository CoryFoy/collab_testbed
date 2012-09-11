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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120805134632) do

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "grants", :force => true do |t|
    t.string   "title"
    t.decimal  "amount"
    t.date     "date_awarded"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "grants_research_areas", :id => false, :force => true do |t|
    t.integer "grant_id"
    t.integer "research_area_id"
  end

  create_table "patents", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "patents_research_areas", :id => false, :force => true do |t|
    t.integer "patent_id"
    t.integer "research_area_id"
  end

  create_table "publications", :force => true do |t|
    t.string   "name"
    t.integer  "venue_id"
    t.datetime "publication_date"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "publications_research_areas", :id => false, :force => true do |t|
    t.integer "publication_id"
    t.integer "research_area_id"
  end

  create_table "publications_researchers", :id => false, :force => true do |t|
    t.integer "publication_id"
    t.integer "researcher_id"
  end

  create_table "research_areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "researchers", :force => true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
