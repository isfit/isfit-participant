class ChangeAmountFormatInWorkshopApplications < ActiveRecord::Migration
  def up
    change_column :workshop_applications, :amount, :string
  end

  def down
    change_column :workshop_applications, :amount, :integer
  end
end
