class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :address, :null => false
      t.string :zipcode, :limit => 10, :null => false
      t.string :city, :null => false
      t.integer :country_id, :default => 0, :null => false
      t.string :phone, :limit => 64, :null => false
      t.string :email, :limit => 100, :null => false
      t.date :birthdate, :null => false
      t.string :sex, :limit => 2, :null => false
      t.string :university, :null => false
      t.string :field_of_study, :null => false
      t.integer :workshop1, :default => 0, :null => false
      t.integer :workshop2, :default => 0, :null => false
      t.integer :workshop3, :default => 0, :null => false
      t.text :essay1, :null => false
      t.text :essay2, :null => false
      t.integer :travel_apply, :limit => 1, :default => 0
      t.text :travel_essay
      t.string :travel_amount, :limit => 20, :default => ""
      t.integer :travel_nosupport_other, :limit => 1, :default => 0
      t.integer :travel_nosupport_cancome, :limit => 1, :default => 0
      t.integer :grade1_functionary_id, :default => 0, :null => false
      t.integer :grade1, :limit => 2, :default => 0, :null => false
      t.text :grade1_comment
      t.integer :grade2_functionary_id, :default => 0, :null => false
      t.integer :grade2, :limit => 2, :default => 0, :null => false
      t.text :grade2_comment
      t.integer :total_grade, :limit => 2, :default => 0, :null => false
      t.integer :selection_functionary_id, :default => 0, :null => false
      t.text :selection_comment
      t.integer :travel_functionary_id, :default => 0, :null => false
      t.integer :travel_approved, :limit => 1, :default => 0, :null => false
      t.string :travel_amount_given, :default => 0, :null => false
      t.text :travel_comment
      t.integer :status, :default => 0, :null => false
      t.integer :final_workshop, :default => 0, :null => false
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end
end
