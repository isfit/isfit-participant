class AddEvenMoreFieldsToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :confirmed_participation, :boolean
    add_column :participants, :nationality, :string
    add_column :participants, :country_citizen_id, :integer
    add_column :participants, :active, :boolean
  end
end
