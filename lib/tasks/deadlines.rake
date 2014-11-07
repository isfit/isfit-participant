namespace :deadlines do
  task send_november_reminders: :environment do |task, args|
    count_x = 0
    count_y = 0
    count_z = 0

    # Need visa, either not accepted invitation or applied for visa
    participants_x = Participant.where(need_visa: 1, accepted_invitation: -1)

    participants_x.each do |p|
      begin
        DeadlineMailer.november_reminder_visa(p.user).deliver
        count_x += 1
        puts "Visa mail sent to #{p.user.email}"
      rescue
        puts "Failed mail to #{p.user.email}"
      end
    end

    participants_y = Participant.where(need_visa: 1, accepted_invitation: 1, applied_visa: -1)

    participants_y.each do |p|
      begin
        DeadlineMailer.november_reminder_visa(p.user).deliver
        count_y += 1
        puts "Visa mail sent to #{p.user.email}"
      rescue
        puts "Failed mail to #{p.user.email}"
      end
    end

    # Doesn't need visa, not accepted deadline
    participants_z = Participant.where(need_visa: 0, accepted_invitation: -1)

    participants_z.each do |p|
      begin
        DeadlineMailer.november_reminder_no_visa(p.user).deliver
        count_z += 1
        puts "No visa mail sent to #{p.user.email}"
      rescue
        puts "Failed mail to #{p.user.email}"
      end
    end

    # Stats, love it
    puts "Mail to group 1: #{count_x}"
    puts "Mail to group 2: #{count_y}"
    puts "Mail to group 3: #{count_z}"
  end
end