class AddDeadlineToParticipants < ActiveRecord::Migration
  def up
    add_column :participants, :approved_first_deadline, :boolean, default: 0, null: false

    # Approve first deadline for persons that have done it right
    Participant.where(need_visa: 0, accepted_invitation: 1)
      .update_all(approved_first_deadline: 1)
    Participant.where(need_visa: 1, accepted_invitation: 1, applied_visa: 1)
      .update_all(approved_first_deadline: 1)

    # Set persons waiting to apply for visa to pending
    @participants = Participant.where(need_visa: 1, accepted_invitation: 1, applied_visa: 2)
      .update_all(approved_first_deadline: 2)

    # Throw out participants that didn't hold first deadline
    @participants = Participant.where(approved_first_deadline: 0)

    @participants.each do |participant|
      participant.user.active = 0
      participant.user.save
    end
  end

  def down
    remove_column :participants, :approved_first_deadline
  end
end
