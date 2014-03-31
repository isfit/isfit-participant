class MoveEmailToUsersTable < ActiveRecord::Migration
  def up
    User.find_each do |user|
      if user.functionary
        user.email = user.functionary.email
        user.save
      elsif user.participant
        user.email = user.participant.email
        user.save
      end
    end
  end

  def down
    User.find_each do |user|
      if user.functionary
        user.functionary.email = user.email
        user.save
      elsif user.participant
        user.participant.email = user.email
        user.save
      end
    end
  end
end
