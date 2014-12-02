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

ActiveRecord::Schema.define(:version => 20141202191838) do

  create_table "answers", :force => true do |t|
    t.text     "content"
    t.integer  "question_id", :null => false
    t.integer  "user_id",     :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "created_at",  :null => false
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "arrival_places", :force => true do |t|
    t.string "name"
  end

  create_table "countries", :force => true do |t|
    t.string  "name"
    t.string  "code",    :limit => 4
    t.integer "user_id"
  end

  add_index "countries", ["user_id"], :name => "index_countries_on_user_id"

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

  create_table "faq_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "questions_count", :default => 0
  end

  create_table "faq_questions", :force => true do |t|
    t.string   "question"
    t.text     "answer"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "faq_questions", ["category_id"], :name => "index_faq_questions_on_category_id"

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
    t.integer  "workshop_id"
    t.integer  "accepted_invitation",      :limit => 1, :default => -1
    t.integer  "user_id"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.integer  "need_visa",                :limit => 1, :default => -1
    t.integer  "applied_visa",             :limit => 1, :default => -1
    t.integer  "granted_amount",           :limit => 2
    t.boolean  "approved_first_deadline",               :default => false, :null => false
    t.string   "visa_number"
    t.integer  "approved_second_deadline",              :default => 0,     :null => false
  end

  add_index "participants", ["user_id"], :name => "index_participants_on_user_id"
  add_index "participants", ["workshop_id"], :name => "index_participants_on_workshop_id"

  create_table "profiles", :force => true do |t|
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "citizenship"
    t.integer  "calling_code"
    t.string   "phone",                  :limit => 30
    t.date     "date_of_birth"
    t.integer  "gender",                 :limit => 1
    t.string   "gender_specify"
    t.string   "school"
    t.string   "field_of_study"
    t.integer  "user_id"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.integer  "country_id"
    t.integer  "citizenship_id"
    t.string   "nationality"
    t.text     "motivation_essay",                                        :null => false
    t.string   "next_of_kin_name"
    t.string   "next_of_kin_phone"
    t.text     "next_of_kin_address"
    t.string   "next_of_kin_relation"
    t.integer  "dietary_law",                          :default => 0
    t.string   "other_diet_preferences"
    t.boolean  "allergy_animals",                      :default => false
    t.boolean  "allergy_gluten",                       :default => false
    t.boolean  "allergy_lactose",                      :default => false
    t.boolean  "allergy_nuts",                         :default => false
    t.string   "other_allergies"
    t.integer  "host_gender_preference",               :default => 0
    t.boolean  "smoke",                                :default => false
    t.boolean  "handicap",                             :default => false
    t.string   "other_host_preferences"
  end

  create_table "questions", :force => true do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "status"
    t.integer  "user_id",    :null => false
    t.integer  "owner_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "transport_types", :force => true do |t|
    t.string   "name"
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
    t.integer  "workshop_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["workshop_id"], :name => "index_users_on_workshop_id"

  create_table "workshop_applications", :force => true do |t|
    t.integer  "workshop_1_id"
    t.integer  "workshop_2_id"
    t.integer  "workshop_3_id"
    t.text     "workshop_essay",                                                :null => false
    t.boolean  "applying_for_support"
    t.text     "financial_aid_essay",                                           :null => false
    t.string   "amount"
    t.boolean  "other_sources"
    t.boolean  "still_attend"
    t.integer  "profile_reviewer_id"
    t.integer  "profile_grade"
    t.integer  "workshop_application_grade"
    t.integer  "workshop_recommendation_id"
    t.integer  "workshop_application_reviewer_id"
    t.integer  "user_id"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.integer  "status",                           :limit => 1, :default => -1
  end

  add_index "workshop_applications", ["profile_reviewer_id"], :name => "index_workshop_applications_on_profile_reviewer_id"
  add_index "workshop_applications", ["user_id"], :name => "index_workshop_applications_on_user_id"
  add_index "workshop_applications", ["workshop_1_id"], :name => "index_workshop_applications_on_workshop_1_id"
  add_index "workshop_applications", ["workshop_2_id"], :name => "index_workshop_applications_on_workshop_2_id"
  add_index "workshop_applications", ["workshop_3_id"], :name => "index_workshop_applications_on_workshop_3_id"
  add_index "workshop_applications", ["workshop_application_reviewer_id"], :name => "index_workshop_applications_on_workshop_application_reviewer_id"
  add_index "workshop_applications", ["workshop_recommendation_id"], :name => "index_workshop_applications_on_workshop_recommendation_id"

  create_table "workshops", :force => true do |t|
    t.string   "title"
    t.string   "lead"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
