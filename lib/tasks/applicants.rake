namespace :applicants do
  task send_waiting_list_rejection_mails: :environment do |task, args|
    applications = WorkshopApplication.where(status: 4)
    counter = 0

    applications.each do |a|
      begin
        ApplicantMailer.waiting_list_rejection_mail(a.user).deliver
        counter += 1
        puts "Waiting list rejection mail sent to #{a.user.email}"
      rescue
        puts "Failed sending mail to #{p.user.email}"
      end
    end

    print "#{counter} mails sent"
  end
end