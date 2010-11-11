class AddInformationToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :arrives_at, :datetime
    add_column :participants, :departs_at, :datetime
    add_column :participants, :arrival_place_id, :integer
    add_column :participants, :need_transport, :integer
    add_column :participants, :next_of_kin_name, :string
    add_column :participants, :next_of_kin_phone, :string
    add_column :participants, :next_of_kin_address, :text
    add_column :participants, :flightnumber, :integer
    add_column :participants, :has_passport, :integer
  end

  def self.down
    remove_column :participants, :has_passport
    remove_column :participants, :flightnumber
    remove_column :participants, :next_of_kin_address
    remove_column :participants, :next_of_kin_phone
    remove_column :participants, :next_of_kin_name
    remove_column :participants, :need_transport
    remove_column :participants, :arrival_place_id
    remove_column :participants, :departs_at
    remove_column :participants, :arrives_at
  end
end
