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




  def generate_password(size = 8)
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end
end
