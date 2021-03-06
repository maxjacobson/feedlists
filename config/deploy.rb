require 'bundler/capistrano' # for bundler support

set :application, "feedlists"
set :repository,  "git@github.com:maxjacobson/feedlists.git"

set :user, 'deploy'
set :deploy_to, "/home/#{ user }/#{ application }"
set :use_sudo, false

set :scm, :git

default_run_options[:pty] = true

role :web, "192.241.250.92"    # Your HTTP server, Apache/etc
role :app, "192.241.250.92"    # This may be the same as your `Web` server

before "deploy:assets:precompile", "deploy:symlink_config"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
 task :symlink_config, :roles => :app do 
   run "ln -nfs #{shared_path}/production.sqlite3 #{current_release}/db/production.sqlite3"
   run "ln -nfs #{shared_path}/application.yml #{current_release}/config/application.yml"
 end
end