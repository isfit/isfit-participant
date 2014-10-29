require 'csv'

namespace :applicants do
  desc "Falgs user that should be invited to the festival"
  task :set_invited, [:file] => :environment do |task, args|
    csv_data = File.read(args[:file])
    csv = CSV.parse(csv_data, headers: false)

    csv.each do |row|
      user_id = row[0].to_i
      workshop_id = row[1].to_i

      u = User.find(user_id)

      # Create new participant
      Participant.create(user_id: user_id, workshop_id: workshop_id)
      
      # Set application status
      u.workshop_application.status = 1
      u.workshop_application.save

      # Set new role
      u.role = 'participant'
      u.save
    end
  end

  desc 'Put users on waiting list'
  task :set_waiting, [:file] => :environment do |task, args|
    csv_data = File.read(args[:file])
    csv = CSV.parse(csv_data, headers: false)

    csv.each do |row|
      # Loads user
      user_id = row[0].to_i
      u = User.find(user_id)

      # Set application status
      u.workshop_application.status = 2
      u.workshop_application.save
    end

    puts 'Waiting list generated'
  end

  desc 'Set rest of applications as declined'
  task set_declined: :environment do |task, args|
    applications = WorkshopApplication.where(status: -1)

    applications.each do |wa|
      if wa.user.dialogue_application
        wa.status = 3
      else
        wa.status = 0
      end

      wa.save
    end
  end
end