class AddArrivalInformationToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :arrival_in_norway, :integer, default: -1
    add_column :participants, :osl_arrival_date, :string
    add_column :participants, :osl_arrival_flight_number, :string
    add_column :participants, :trd_arrival_date, :string
    add_column :participants, :trd_arrival_flight_number, :string
    add_column :participants, :other_arrival_information, :text
  end
end
