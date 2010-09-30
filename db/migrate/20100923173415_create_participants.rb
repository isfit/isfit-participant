class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :date_of_birth
      t.string :address1
      t.string :address2
      t.integer :zipcode
      t.string :city
      t.integer :country_id
      t.integer :sex
      t.string :field_of_study
      t.integer :workshop
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
