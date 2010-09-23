class CreateFunctionaries < ActiveRecord::Migration
  def self.up
    create_table :functionaries do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :functionaries
  end
end
