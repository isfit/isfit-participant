cp config/database.yml.example config/database.yml

mysql -e 'CREATE database isfit13_pw_test;'

bundle exec rake db:create
bundle exec rake db:schema:load

