class AddTransferToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :transfer_to_trd, :integer, default: -1
    add_column :participants, :other_transfer_information, :text
  end
end
