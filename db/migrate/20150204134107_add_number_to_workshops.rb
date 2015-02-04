class AddNumberToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :number, :integer
  end
end
