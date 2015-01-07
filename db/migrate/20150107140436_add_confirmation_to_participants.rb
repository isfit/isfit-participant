class AddConfirmationToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :confirmed_participation, :integer, default: -1
    add_column :participants, :approved_third_deadline, :integer, default: -1
  end
end
