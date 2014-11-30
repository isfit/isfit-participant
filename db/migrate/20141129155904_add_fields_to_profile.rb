class AddFieldsToProfile < ActiveRecord::Migration
  def change
    # Next of kin information
    add_column :profiles, :next_of_kin_name,    :string
    add_column :profiles, :next_of_kin_phone,   :string
    add_column :profiles, :next_of_kin_address, :text

    # Diets and allergies
    add_column :profiles, :dietary_law,             :integer, default: 0
    add_column :profiles, :other_diet_preferences,  :string

    add_column :profiles, :allergy_animals, :boolean, default: false
    add_column :profiles, :allergy_gluten,  :boolean, default: false
    add_column :profiles, :allergy_lactose, :boolean, default: false
    add_column :profiles, :allergy_nuts,    :boolean, default: false
    add_column :profiles, :other_allergies, :string

    # Host preferences
    add_column :profiles, :host_gender_preference, :integer, default: 0
    add_column :profiles, :smoke,                  :boolean, default: false
    add_column :profiles, :handicap,               :boolean, default: false
    add_column :profiles, :other_host_preferences, :string
  end
end
