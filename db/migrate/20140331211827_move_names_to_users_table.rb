class MoveNamesToUsersTable < ActiveRecord::Migration
  def up
    User.find_each do |user|
      if user.functionary
        user.first_name = user.functionary.first_name
        user.last_name = user.functionary.last_name
        user.save
      elsif user.participant
        user.first_name = user.participant.first_name
        user.last_name = user.participant.last_name
        user.save
      end
    end
  end

  def down
    User.find_each do |user|
      if user.functionary
        user.functionary.first_name = user.first_name
        user.functionary.last_name = user.last_name
        user.save
      elsif user.participant
        user.participant.first_name = user.first_name
        user.participant.last_name = user.last_name
        user.save
      end
    end
  end
end
