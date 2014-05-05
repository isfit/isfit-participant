class CreateFinancialAidApplications < ActiveRecord::Migration
  def change
    create_table :financial_aid_applications do |t|
      t.text :essay
      t.integer :amount
      t.boolean :other_sources
      t.boolean :can_come_anyway
      t.integer :user_id

      t.timestamps
    end
  end
end
