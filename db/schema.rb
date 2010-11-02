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

ActiveRecord::Schema.define(:version => 20101101190657) do

  create_table "answers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "functionary_id"
    t.datetime "publish_at"
    t.integer  "user_id"
    t.integer  "sticky"
  end

  create_table "countries", :force => true do |t|
    t.string  "name",      :null => false
    t.integer "region_id", :null => false
  end

  create_table "deadlines", :force => true do |t|
    t.datetime "deadline"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deadlines_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "deadline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "functionaries", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "information_categories", :force => true do |t|
    t.string "title"
  end

  create_table "information_pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "information_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.date     "date_of_birth"
    t.string   "address1"
    t.string   "address2"
    t.integer  "zipcode"
    t.string   "city"
    t.integer  "country_id"
    t.integer  "sex"
    t.string   "field_of_study"
    t.integer  "workshop"
    t.integer  "user_id"
    t.integer  "functionary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "arrives_at"
    t.datetime "departs_at"
    t.integer  "arrival_place_id"
    t.integer  "need_transport"
    t.string   "next_of_kin_name"
    t.string   "next_of_kin_phone"
    t.text     "next_of_kin_address"
    t.integer  "flightnumber"
    t.integer  "has_passport"
    t.integer  "accepted"
    t.integer  "visa"
    t.integer  "transport_type_id"
    t.integer  "travel_support"
    t.integer  "applied_for_visa"
    t.integer  "notified"
  end

  create_table "participants_reals", :force => true do |t|
    t.datetime "registered_time",                                              :null => false
    t.datetime "checked_in"
    t.datetime "picked_up"
    t.string   "first_name",                                                   :null => false
    t.string   "middle_name",                :limit => 64
    t.string   "last_name",                                                    :null => false
    t.string   "address1",                                  :default => "",    :null => false
    t.string   "address2"
    t.string   "zipcode",                    :limit => 10,  :default => "",    :null => false
    t.string   "city",                                      :default => "",    :null => false
    t.integer  "country_id",                                :default => 0,     :null => false
    t.string   "phone",                      :limit => 64,                     :null => false
    t.string   "email",                      :limit => 100, :default => "",    :null => false
    t.string   "fax",                        :limit => 20
    t.string   "nationality",                               :default => "",    :null => false
    t.date     "birthdate",                                                    :null => false
    t.string   "sex",                        :limit => 2,   :default => "",    :null => false
    t.string   "university",                                :default => "",    :null => false
    t.string   "field_of_study",                                               :null => false
    t.string   "org_name"
    t.string   "org_function"
    t.string   "hear_about_isfit"
    t.string   "hear_about_isfit_other"
    t.integer  "workshop1",                                 :default => 0,     :null => false
    t.integer  "workshop2",                                 :default => 0,     :null => false
    t.integer  "workshop3",                                 :default => 0,     :null => false
    t.text     "essay1",                                                       :null => false
    t.text     "essay2",                                                       :null => false
    t.integer  "travel_apply",               :limit => 1,   :default => 0
    t.text     "travel_essay"
    t.string   "travel_amount",              :limit => 20
    t.integer  "travel_nosupport_other",     :limit => 1,   :default => 0
    t.integer  "travel_nosupport_cancome",   :limit => 1,   :default => 0
    t.integer  "participant_grade",          :limit => 1,   :default => 0,     :null => false
    t.text     "participant_comment"
    t.integer  "participant_functionary_id",                :default => 0,     :null => false
    t.integer  "theme_grade1",               :limit => 1,   :default => 1,     :null => false
    t.integer  "theme_grade2",               :limit => 1,   :default => 1,     :null => false
    t.text     "theme_comment"
    t.text     "theme_comment_2"
    t.integer  "theme_functionary_id_2",                    :default => 0
    t.integer  "theme_functionary_id",                      :default => 0,     :null => false
    t.string   "password"
    t.integer  "final_workshop",                            :default => 0,     :null => false
    t.integer  "invited",                    :limit => 1,   :default => 0,     :null => false
    t.integer  "travel_assigned",            :limit => 1,   :default => 0,     :null => false
    t.integer  "travel_assigned_amount",                    :default => 0,     :null => false
    t.text     "travel_comment"
    t.integer  "host_id"
    t.datetime "last_login"
    t.boolean  "notified_invitation",                       :default => false, :null => false
    t.boolean  "notified_travel_support",                   :default => false, :null => false
    t.boolean  "notified_rejection",                        :default => false, :null => false
    t.boolean  "notified_no_travel_support",                :default => false, :null => false
    t.boolean  "notified_rejection_again",                  :default => false, :null => false
    t.date     "arrival_date"
    t.string   "arrival_place",              :limit => 100
    t.time     "arrival_time"
    t.string   "arrival_carrier",            :limit => 5
    t.boolean  "arrival_isfit_trans"
    t.string   "arrival_airline",            :limit => 30
    t.string   "arrival_flight_number",      :limit => 10
    t.date     "departure_date"
    t.time     "departure_time"
    t.string   "departure_carrier",          :limit => 5
    t.boolean  "departure_isfit_trans"
    t.string   "departure_place",            :limit => 100
    t.boolean  "notified_custom",                           :default => false, :null => false
    t.boolean  "blocked",                                   :default => false, :null => false
    t.datetime "request_travel"
    t.integer  "accept_travel",              :limit => 1
    t.datetime "accept_travel_time"
    t.integer  "bed",                        :limit => 1,   :default => 0,     :null => false
    t.integer  "bedding",                    :limit => 1,   :default => 0,     :null => false
    t.boolean  "special_invite",                            :default => false, :null => false
    t.boolean  "deleted",                                   :default => false
  end

  add_index "participants_reals", ["email"], :name => "email", :unique => true

  create_table "question_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "dialogue"
    t.integer  "participant_id"
    t.integer  "question_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
  end

  create_table "regions", :force => true do |t|
    t.string "name"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["authorizable_id"], :name => "index_roles_on_authorizable_id"
  add_index "roles", ["authorizable_type"], :name => "index_roles_on_authorizable_type"
  add_index "roles", ["name", "authorizable_id", "authorizable_type"], :name => "index_roles_on_name_and_authorizable_id_and_authorizable_type", :unique => true
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id", "role_id"], :name => "index_roles_users_on_user_id_and_role_id", :unique => true
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "transport_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "first_password"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_deadlines", :force => true do |t|
    t.integer  "user_id"
    t.integer  "deadline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
