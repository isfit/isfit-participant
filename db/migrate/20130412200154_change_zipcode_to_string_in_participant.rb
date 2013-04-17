class ChangeZipcodeToStringInParticipant < ActiveRecord::Migration
  def up
    change_column :participants, :zipcode, :string
  end

  def down
    change_column :participants, :zipcode, :integer
  end
end
