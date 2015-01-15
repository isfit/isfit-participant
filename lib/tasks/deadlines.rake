namespace :deadlines do
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
        #DeadlineMailer.december_reminder_visa(p.user).deliver
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

  task send_failed_january_deadline: :environment do |task, args|
    participants = Participant.where(approved_first_deadline: [1, 2], approved_second_deadline: [1, 2], approved_third_deadline: -1)

    participants.each do |p|
      begin
        DeadlineMailer.failed_janaury_deadline(p.user).deliver
        puts "Failed january deadline delivered to #{p.user.full_name} [#{p.user.email}]"
      rescue
        puts "Delivery to #{p.user.full_name} [#{p.user.email}] failed"
      end
    end
  end

  task send_january_deadline_reminder: :environment do |task, args|
    participants = Participant.where(approved_first_deadline: [1, 2], approved_second_deadline: [1, 2], approved_third_deadline: -1)
    counter = 0

    participants.each do |p|
      begin
        DeadlineMailer.january_reminder(p.user).deliver
        counter += 1
        puts "Reminder mail sent to #{p.user.email}"
      rescue
        puts "Delivery to #{p.user.email} failed"
      end
    end

    puts "Reminder mails sent: #{counter}"
  end
end