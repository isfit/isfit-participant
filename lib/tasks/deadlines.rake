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

  task send_failed_first_deadline: :environment do |task, args|
    participants = Participant.joins(:user).where(approved_first_deadline: 0)

    participants.each do |p|
      begin
        DeadlineMailer.failed_first_deadline(p.user).deliver
        puts "First deadline fail mail sent to #{p.user.email}"
      rescue
        puts "Failed mailing to #{p.user.email}"
      end
    end
  end

  task send_december_reminders: :environment do |task, args|
    # Fetch participants depending on beed for visa or not
    participants_no_visa = Participant.joins(:user).where(approved_first_deadline: [1, 2], approved_second_deadline: 0, need_visa: 0)
    participants_visa = Participant.joins(:user).where(approved_first_deadline: [1, 2], approved_second_deadline: 0, need_visa: 1)

    # Counters
    counter_participants_no_visa = 0
    counter_participants_visa = 0

    # Send mail to participants that does not need visa
    participants_no_visa.each do |p|
      begin
        DeadlineMailer.december_reminder_no_visa(p.user).deliver
        counter_participants_no_visa += 1
        puts "Reminder mail without visa to #{p.user.email}"
      rescue 
        puts "Delivery to #{p.user.email} to failed"
      end
    end

    # Send mail to participants that needs visa
    participants_visa.each do |p|
      begin
        DeadlineMailer.december_reminder_visa(p.user).deliver
        counter_participants_visa += 1
        puts "Reminder mail with visa to #{p.user.email}"
      rescue 
        puts "Delivery to #{p.user.email} failed"
      end
    end

    # Stats, love it
    puts "Mail participants without visa: #{counter_participants_no_visa}"
    puts "Mail participants with visa: #{counter_participants_visa}"
  end
end