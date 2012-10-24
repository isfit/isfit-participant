class AddMoreFieldsToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :invited, :boolean, :nil => false
    add_column :participants, :halal, :boolean, :default => false
    add_column :participants, :agree_waiting_list, :boolean
    add_column :participants, :visa_number, :string
    remove_column :participants, :address2
    remove_column :participants, :middle_name
  end
end
