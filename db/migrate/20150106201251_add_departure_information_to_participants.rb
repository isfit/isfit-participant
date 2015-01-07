class AddDepartureInformationToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :osl_departure_date, :string
    add_column :participants, :osl_departure_flight_number, :string
    add_column :participants, :trd_departure_date, :string
    add_column :participants, :trd_departure_flight_number, :string
    add_column :participants, :other_trondheim_departure_information, :text
    add_column :participants, :other_norway_departure_information, :text
  end
end
