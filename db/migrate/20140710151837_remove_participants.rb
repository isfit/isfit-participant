class RemoveParticipants < ActiveRecord::Migration
  def up
    drop_table :participants
  end

  def down
    create_table :participants do |t|
      t.date     :date_of_birth
      t.string   :address1
      t.string   :zipcode
      t.string   :city
      t.integer  :country_id
      t.integer  :sex
      t.string   :field_of_study
      t.integer  :workshop_id
      t.integer  :user_id
      t.integer  :functionary_id
      t.datetime :created_at,                                 null: false
      t.datetime :updated_at,                                 null: false
      t.datetime :arrives_at
      t.datetime :departs_at
      t.integer  :arrival_place_id
      t.integer  :need_transport
      t.string   :next_of_kin_name
      t.string   :next_of_kin_phone
      t.text     :next_of_kin_address
      t.string   :flightnumber
      t.integer  :has_passport
      t.integer  :accepted
      t.integer  :visa
      t.integer  :transport_type_id
      t.integer  :travel_support
      t.integer  :applied_for_visa
      t.integer  :notified
      t.boolean  :dialogue
      t.boolean  :media_consent
      t.boolean  :subscribe_consent
      t.integer  :embassy_confirmation,    default: 0,     null: false
      t.boolean  :allergy_lactose
      t.boolean  :allergy_gluten
      t.boolean  :allergy_nuts
      t.string   :allergy_other
      t.boolean  :vegetarian
      t.boolean  :guaranteed
      t.boolean  :smoke
      t.string   :handicap
      t.boolean  :allergy_pets
      t.integer  :host_id
      t.datetime :checked_in
      t.datetime :checked_out
      t.boolean  :spp
      t.boolean  :invited
      t.boolean  :halal,                   default: false
      t.boolean  :agree_waiting_list
      t.string   :visa_number
      t.string   :visum_file_name
      t.string   :visum_content_type
      t.integer  :visum_file_size
      t.datetime :visum_updated_at
      t.boolean  :confirmed_participation
      t.string   :nationality
      t.integer  :country_citizen_id
      t.boolean  :active
      t.boolean  :ignore,                  default: false
      t.string   :phone_number
    end
  end
end
