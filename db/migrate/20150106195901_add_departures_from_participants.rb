class AddDeparturesFromParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :departure_trd, :integer, default: -1
    add_column :participants, :departure_norway, :integer, default: -1
  end
end
