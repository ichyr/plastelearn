require "whenever/capistrano"
set :whenever_command, "bundle exec whenever"

set :default_run_options, {
  shell: '/bin/bash --login'
}


set :stage, :production
set :application, "plastelearn"

# setup rvm.
set :rbenv_ruby, '2.1.2'
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# how many old releases do we want to keep
set :keep_releases, 5

set :default_env, {
    :PATH => '/home/specplast/.rbenv/plugins/ruby-build/bin:/home/specplast/.rbenv/shims:/home/specplast/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/specplast/.rbenv/shims/bundler'
}

set :default_environment, {
  :PATH => '/home/specplast/.rbenv/plugins/ruby-build/bin:/home/specplast/.rbenv/shims:/home/specplast/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/specplast/.rbenv/shims/bundler'
}

set :scm, :git
set :repo_url,  "git@github.com:ichyr/#{fetch(:application)}.git"
set :branch, 'production'

set :deploy_to, "/var/www/plastelearn_prod"

set :ssh_options, {
  forward_agent: true,
  port: 10375
}

set :log_level, :debug

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/system}

SSHKit.config.command_map[:rake]  = "bundle exec rake" #8
SSHKit.config.command_map[:rails] = "bundle exec rails"


namespace :deploy do

  desc "checks whether the currently checkout out revision matches the
  remote one we're trying to deploy from"
    task :check_revision do
      branch = fetch(:branch)
      unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
        puts "WARNING: HEAD is not the same as origin/#{branch}"
        puts "Run `git push` to sync changes or make sure you've"
        puts "checked out the branch: #{branch} as you can only deploy"
        puts "if you've got the target branch checked out"
      exit
    end
  end

  %w[start stop restart].each do |command|
    desc "#{command} Unicorn server."
    task command do
      on roles(:app) do
        execute "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
      end
    end
  end

  # desc "Update the crontab file"
  # task :update_crontab do
  #   run "cd #{current_path} && whenever -i #{:application} --update-crontab"
  # end

  before :deploy, "deploy:check_revision"
  after :deploy, "deploy:restart"
  after :rollback, "deploy:restart"
  # after :deploy, "deploy:update_crontab"

end
