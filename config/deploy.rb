#========================
#CONFIG
#========================
set :application, "www.rubyconf.com.ar"
set :scm, :git
set :git_enable_submodules, 1
set :repository, "git://github.com/lucasefe/rubyconfar-website.git"
set :branch, "production"
set :ssh_options, { :forward_agent => true }
set :stage, :production
set :user, "lucas"
set :use_sudo, false
set :runner, "deploy"
set :deploy_to, "/var/apps/#{application}"
set :app_server, :passenger
set :domain, "www.rubyconf.com.ar"

role :app, domain
role :web, domain
role :db, domain, :primary => true

namespace :deploy do  
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
  
  task :stop, :roles => :app do
    # Do nothing.
  end
  
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

namespace :app do
  task :update_config_file, :roles => :app do
    run "cp -r #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
  end  
end
after  "deploy:update_code",  "app:update_config_file"