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

ActiveRecord::Schema.define(:version => 20140408101106) do

  create_table "answers", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "question_id"
    t.text     "content"
    t.integer  "user_id"
  end

  create_table "applications", :force => true do |t|
    t.string   "first_name",                                                 :null => false
    t.string   "last_name",                                                  :null => false
    t.string   "address",                                                    :null => false
    t.string   "zipcode",                  :limit => 10,                     :null => false
    t.string   "city",                                                       :null => false
    t.integer  "country_id",                              :default => 0,     :null => false
    t.string   "phone",                    :limit => 64,                     :null => false
    t.string   "email",                    :limit => 100,                    :null => false
    t.date     "birthdate",                                                  :null => false
    t.string   "sex",                      :limit => 2,                      :null => false
    t.string   "university",                                                 :null => false
    t.string   "field_of_study",                                             :null => false
    t.integer  "workshop1",                               :default => 0,     :null => false
    t.integer  "workshop2",                               :default => 0,     :null => false
    t.integer  "workshop3",                               :default => 0,     :null => false
    t.text     "essay1",                                                     :null => false
    t.text     "essay2",                                                     :null => false
    t.integer  "travel_apply",             :limit => 1,   :default => 0
    t.text     "travel_essay"
    t.string   "travel_amount",            :limit => 20,  :default => ""
    t.integer  "travel_nosupport_other",   :limit => 1,   :default => 0
    t.integer  "travel_nosupport_cancome", :limit => 1,   :default => 0
    t.integer  "grade1_functionary_id",                   :default => 0,     :null => false
    t.integer  "grade1",                   :limit => 2,   :default => 0,     :null => false
    t.text     "grade1_comment"
    t.integer  "grade2_functionary_id",                   :default => 0,     :null => false
    t.integer  "grade2",                   :limit => 2,   :default => 0,     :null => false
    t.text     "grade2_comment"
    t.integer  "total_grade",              :limit => 2,   :default => 0,     :null => false
    t.integer  "selection_functionary_id",                :default => 0,     :null => false
    t.text     "selection_comment"
    t.integer  "travel_functionary_id",                   :default => 0,     :null => false
    t.integer  "travel_approved",          :limit => 1,   :default => 0,     :null => false
    t.string   "travel_amount_given",                     :default => "0",   :null => false
    t.text     "travel_comment"
    t.integer  "status",                                  :default => 0,     :null => false
    t.integer  "final_workshop",                          :default => 0,     :null => false
    t.boolean  "deleted",                                 :default => false
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "travel_status",                           :default => 0,     :null => false
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

  create_table "control_panels", :force => true do |t|
    t.boolean  "app_grade1",       :default => false
    t.boolean  "app_grade2",       :default => false
    t.boolean  "app_grade3",       :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "app_grade2_scope"
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

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "functionaries", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "functionaries_participants", :id => false, :force => true do |t|
    t.integer  "functionary_id"
    t.integer  "participant_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
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

  create_table "participants", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.date     "date_of_birth"
    t.string   "address1"
    t.string   "zipcode"
    t.string   "city"
    t.integer  "country_id"
    t.integer  "sex"
    t.string   "field_of_study"
    t.integer  "workshop_id"
    t.integer  "user_id"
    t.integer  "functionary_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.datetime "arrives_at"
    t.datetime "departs_at"
    t.integer  "arrival_place_id"
    t.integer  "need_transport"
    t.string   "next_of_kin_name"
    t.string   "next_of_kin_phone"
    t.text     "next_of_kin_address"
    t.string   "flightnumber"
    t.integer  "has_passport"
    t.integer  "accepted"
    t.integer  "visa"
    t.integer  "transport_type_id"
    t.integer  "travel_support"
    t.integer  "applied_for_visa"
    t.integer  "notified"
    t.boolean  "dialogue"
    t.boolean  "media_consent"
    t.boolean  "subscribe_consent"
    t.integer  "embassy_confirmation",    :default => 0,     :null => false
    t.boolean  "allergy_lactose"
    t.boolean  "allergy_gluten"
    t.boolean  "allergy_nuts"
    t.string   "allergy_other"
    t.boolean  "vegetarian"
    t.boolean  "guaranteed"
    t.boolean  "smoke"
    t.string   "handicap"
    t.boolean  "allergy_pets"
    t.integer  "host_id"
    t.datetime "checked_in"
    t.datetime "checked_out"
    t.boolean  "spp"
    t.boolean  "invited"
    t.boolean  "halal",                   :default => false
    t.boolean  "agree_waiting_list"
    t.string   "visa_number"
    t.string   "visum_file_name"
    t.string   "visum_content_type"
    t.integer  "visum_file_size"
    t.datetime "visum_updated_at"
    t.boolean  "confirmed_participation"
    t.string   "nationality"
    t.integer  "country_citizen_id"
    t.boolean  "active"
    t.boolean  "ignore",                  :default => false
    t.string   "phone_number"
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

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "first_password"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "workshops", :force => true do |t|
    t.string   "name"
    t.text     "ingress"
    t.text     "body"
    t.integer  "number"
    t.integer  "user_id"
    t.boolean  "published"
    t.boolean  "got_comments"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "workshop_image_file_name"
    t.string   "workshop_image_content_type"
    t.integer  "workshop_image_file_size"
    t.datetime "workshop_image_updated_at"
  end

  add_index "workshops", ["user_id"], :name => "index_workshops_on_user_id"

end
