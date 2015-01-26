namespace :participants do
  task send_general_information_mails: :environment do |task, args|
    participants = Participant.where(approved_third_deadline: 1)
    counter = 0

    participants.each do |p|
      begin
        ParticipantMailer.general_information(a.user).deliver
        counter += 1
        puts "General information mail sent to #{p.user.email}"
      rescue
        puts "Failed sending mail to #{p.user.email}"
      end
    end

    puts "#{counter} mails sent"
  end
end