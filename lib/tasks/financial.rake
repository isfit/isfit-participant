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
end