class AddTrainsToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :train_arrival_datetime, :string
    add_column :participants, :train_departure_datetime, :string
  end
end
