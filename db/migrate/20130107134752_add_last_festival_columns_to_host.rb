class AddLastFestivalColumnsToHost < ActiveRecord::Migration
  def change
    change_table :hosts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address
      t.integer :zipcode
      t.string :place
      t.integer :number
      t.text :other
      t.boolean :student
      t.boolean :deleted
    end
  end
end
