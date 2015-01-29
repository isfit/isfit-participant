class AddInternalCommentsToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :internal_comments, :text
  end
end
