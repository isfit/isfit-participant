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

ActiveRecord::Schema.define(:version => 20140820062854) do

  create_table "answers", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "question_id"
    t.text     "content"
    t.integer  "user_id"
  end

  create_table "arrival_places", :force => true do |t|
    t.string "name"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "functionary_id"
    t.datetime "publish_at"
    t.integer  "user_id"
    t.integer  "sticky"
  end

  create_table "countries", :force => true do |t|
    t.string  "name"
    t.integer "region_id"
    t.string  "code",      :limit => 4
  end

  create_table "deadlines", :force => true do |t|
    t.datetime "deadline"
    t.string   "name"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "participant_type", :default => 0
  end

  create_table "deadlines_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "deadline_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "approved",    :default => false
  end

  create_table "dialogue_applications", :force => true do |t|
    t.integer  "relationship_status",                    :null => false
    t.integer  "english_proficiency",                    :null => false
    t.text     "dialogue_essay",                         :null => false
    t.text     "conflict_essay",                         :null => false
    t.text     "vision_essay",                           :null => false
    t.integer  "user_id",                                :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "ethnicity",           :default => "",    :null => false
    t.boolean  "national",            :default => false, :null => false
    t.string   "realtives",                              :null => false
    t.text     "other_information"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hosts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.integer  "zipcode"
    t.string   "place"
    t.integer  "number"
    t.text     "other"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "student"
    t.boolean  "deleted",    :default => false
  end

  create_table "information_categories", :force => true do |t|
    t.string "title"
  end

  create_table "information_pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "information_category_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "profiles", :force => true do |t|
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "citizenship"
    t.integer  "calling_code"
    t.string   "phone"
    t.date     "date_of_birth"
    t.integer  "gender",           :limit => 1
    t.string   "gender_specify"
    t.string   "school"
    t.string   "field_of_study"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "country_id"
    t.integer  "citizenship_id"
    t.string   "nationality"
    t.text     "motivation_essay",              :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "dialogue"
    t.integer  "participant_id"
    t.integer  "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "question_id"
  end

  create_table "regions", :force => true do |t|
    t.string "name"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "roles", ["authorizable_id"], :name => "index_roles_on_authorizable_id"
  add_index "roles", ["authorizable_type"], :name => "index_roles_on_authorizable_type"
  add_index "roles", ["name", "authorizable_id", "authorizable_type"], :name => "index_roles_on_name_and_authorizable_id_and_authorizable_type", :unique => true
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "transport_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",          :null => false
    t.string   "role",                   :default => "applicant"
    t.string   "encrypted_password",     :default => "",          :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active",                 :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "workshop_applications", :force => true do |t|
    t.integer  "workshop_1_id"
    t.integer  "workshop_2_id"
    t.integer  "workshop_3_id"
    t.text     "workshop_essay",       :null => false
    t.boolean  "applying_for_support"
    t.text     "financial_aid_essay",  :null => false
    t.integer  "amount"
    t.boolean  "other_sources"
    t.boolean  "still_attend"
    t.integer  "user_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "workshop_applications", ["user_id"], :name => "index_workshop_applications_on_user_id"
  add_index "workshop_applications", ["workshop_1_id"], :name => "index_workshop_applications_on_workshop_1_id"
  add_index "workshop_applications", ["workshop_2_id"], :name => "index_workshop_applications_on_workshop_2_id"
  add_index "workshop_applications", ["workshop_3_id"], :name => "index_workshop_applications_on_workshop_3_id"

  create_table "workshops", :force => true do |t|
    t.string   "title"
    t.string   "lead"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
