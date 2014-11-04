require 'csv'

namespace :financial do
  desc 'Loads financial aid acceptance into database'
  task :load, [:file] => :environment do |task, args|
    # Load CSV data and loop through
    csv_data = File.read(args[:file])
    csv = CSV.parse(csv_data, headers: false)

    csv.each do |row|
      user_id = row[0].to_i
      amount = row[1].to_i

      # Load participant and add granted financial aid
      p = Participant.where(user_id: user_id).first
      p.granted_amount = amount
      p.save
    end
  end

  task send_granted: :environment do |task, args|
    participants = Participant.where('granted_amount IS NOT NULL')

    participants.each do |p|
      begin
        FinancialMailer.granted(p.user).deliver
        puts "Granted mail sent to #{p.user.email}"
      rescue
        puts "Failed to send mail to #{p.user.email}"
      end
    end
  end

  task send_not_granted: :environment do |task, args|
    participants = Participant.
      joins('INNER JOIN workshop_applications ON participants.user_id = workshop_applications.user_id').
      where('granted_amount IS NULL AND applying_for_support = 1')

    participants.each do |p|
      begin
        FinancialMailer.not_granted(p.user).deliver
        puts "Not granted mail sent to #{p.user.email}"
      rescue
        puts "Failed to send mail to #{p.user.email}"
      end
    end
  end
end