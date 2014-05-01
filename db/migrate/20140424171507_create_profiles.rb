class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :nationality
      t.string :citizenship
      t.string :country
      t.integer :calling_code, limit: 4
      t.integer :phone
      t.date :date_of_birth
      t.integer :gender, limit: 1
      t.string :gender_specify
      t.string :school
      t.string :field_of_study
      t.integer :user_id

      t.timestamps
    end
  end
end
