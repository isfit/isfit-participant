class AddNextDeadlineToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :visa_number, :string
    add_column :participants, :approved_second_deadline, :integer, null: false, default: 0
  end
end
