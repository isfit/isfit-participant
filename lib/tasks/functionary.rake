namespace :functionary do

  task :create => :environment do
    func = {
    :tanita => {:first  => "Tanita", :last => "Hansen"},
    :hannagri => {:first =>"Hanna", :last => "Grimsrud Husum"},
    :kennej => {:first => "Kenneth", :last => "Johansen"},
    :krisdjup => {:first =>"Kristina", :last => "Djup"},
    :toftoyan => {:first =>"Tor", :last => "Toftøy"},
    :karisyj => {:first => "Kari Synnøve", :last => "Johansen"},
    :marierts => {:first =>"Mari", :last => "Ertsås Øverli"},
    :sophridd => {:first => "Sophie", :last => "Riddervold"},
    :helgasyn => {:first => "Helga", :last => "Kjos-Hanssen"},
    :sofielys => {:first => "Sofie", :last => "Lian"},
    :ullern => {:first => "Eli", :last => "Fyhn Ullern"},
    :kristaf => {:first => "Kristine", :last => "Kjeldstad"},
    :oystf => {:first => "Øysten Bøyum", :last => "Fossum"}
    }
 
    func.each do |username,value|
      password = generate_password.to_s
        email = username.to_s + "@isfit.org"
        first =  value[:first]
        last = value[:last]
        user = User.new(:email => email, :first_password => password, :password => password)
        user.roles << Role.find(2)
        user.save
        Functionary.create(:email => email, :user_id => user.id,:first_name => first, :last_name => last)
    end
  end




  end

namespace :admin do
  task :create => :environment do
     func = {
    :hannah => {:first  => "Hanna", :last => "Haaland"},
    :tuvajako => {:first =>"Tuva", :last => "Rønnes"},
    :malenehu => {:first => "Malene Huse", :last => "Eikrem"},
    :andhaugs => {:first =>"Anders Grønning", :last => "Haugseth"},
    }
 
    func.each do |username,value|
      password = generate_password.to_s
        email = username.to_s + "@isfit.org"
        first =  value[:first]
        last = value[:last]
        user = User.new(:email => email, :first_password => password, :password => password)
        user.roles << Role.find(1)
        user.save
        Functionary.create(:email => email, :user_id => user.id,:first_name => first, :last_name => last)
    end   
  end
end

namespace :participant do

  task :create => :environment do
    func = {
      "5" => ["tanita" ,"hannagri","kennej" ],
      "3" => ["krisdjup" ,"toftoyan" ,"karisyj"],
      "2" => ["marierts" , "sophridd"] ,
      "1" => ["helgasyn","sofielys"] ,
      "4" => ["ullern" , "kristaf" ,"oystf" ]
    }
    role = Role.find(3)
    func.each do |key,value|
      participants = ParticipantsReal.joins(:country).where(:invited => 1).where("countries.region_id = #{key}")
#      participants = []
      counter = 0
      funcs = []
      value.each do |username|
        email = username << "@isfit.org"
        funcs << Functionary.find_by_email(email)
        #p Functionary.find_by_email(email) 
      end
      modulo = value.size
      participants.each do |p|
        password = generate_password.to_s
				p password
        user = User.new(:email => p.email, :first_password => password,
                           :password => password)
        user.roles << role
        user.save
        participant = Participant.create(:first_name => p.first_name,
                                         :last_name => p.last_name,
                                         :address1 => p.address1,
                                         :address2 => p.address2,
                                         :zipcode => p.zipcode,
                                         :city => p.city,
																				 :email => p.email,
																				 :field_of_study => p.field_of_study,
                                         :country_id => p.country_id,
                                         :workshop => p.final_workshop,
                                         :travel_support => p.travel_assigned_amount,
                                         :functionary_id => funcs[counter].id,
                                         :user_id => user.id)


        p participant.id

        counter +=1
        counter %= modulo
      end
      #logikk for å knytte opp med functionaries her
    end
  end

end

def generate_password(size = 8)
  chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
  (1..size).collect{|a| chars[rand(chars.size)] }.join
end

