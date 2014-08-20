class CreateWorkshopApplications < ActiveRecord::Migration
  def change
    create_table :workshop_applications do |t|
      t.references :workshop_1
      t.references :workshop_2
      t.references :workshop_3
      t.text :workshop_essay,           null: false,  default: ''
      t.boolean :applying_for_support
      t.text :financial_aid_essay,     null: false,  default: ''
      t.integer :amount
      t.boolean :other_sources
      t.boolean :still_attend
      t.references :user

      t.timestamps
    end
    add_index :workshop_applications, :workshop_1_id
    add_index :workshop_applications, :workshop_2_id
    add_index :workshop_applications, :workshop_3_id
    add_index :workshop_applications, :user_id
  end
end
