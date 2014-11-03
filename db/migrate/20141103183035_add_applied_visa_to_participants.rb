class AddAppliedVisaToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :applied_visa, :integer, limit: 1, default: -1
  end
end
