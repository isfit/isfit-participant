# RVM bootstrap
#$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3-p392'
set :rvm_type, :user

require 'bundler/capistrano'

set :application, "isfit-participant"
set :repository,  "git@github.com:isfit/isfit-participant"

set :scm, :git

role :web, "nova.isfit.org"                          # Your HTTP server, Apache/etc
role :app, "nova.isfit.org"                          # This may be the same as your `Web` server
role :db,  "nova.isfit.org", :primary => true # This is where Rails migrations will run

set :user, "passenger"
set :use_sudo, false
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
ssh_options[:forward_agent] = true

if ARGV.include?("deploy") && !(ARGV.include?("production") || ARGV.include?("staging"))
  puts "\nInvoke deploy with 'cap staging deploy' or 'cap production deploy'\n\n"
  exit
end

task :production do
  set :branch, "master"
  set :deploy_to, "/srv/www/participant.isfit.org"
  set :deploy_via, :remote_cache
end

task :staging do
  set :branch, "master"
  set :deploy_to, "/srv/www/staging-pw.isfit.org"
  set :deploy_via, :remote_cache
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
after 'deploy:update_code', 'deploy:symlink_shared'

