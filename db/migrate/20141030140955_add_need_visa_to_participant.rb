class AddNeedVisaToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :need_visa, :integer, limit: 1, default: -1
  end
end
