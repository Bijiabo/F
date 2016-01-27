# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'F'
set :repo_url, 'https://github.com/Bijiabo/F.git'
set :deploy_user, 'deploy'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'NearCat'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/project/ruby/NC'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/certificate.pem', 'config/application.yml')
# set :linked_files, fetch(:linked_files, []).push('config/certificate.pem', 'config/application.yml')
# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

# rvm
set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.2.4'      # Defaults to: 'default'
set :rvm_custom_path, '~/.rvm'  # only needed if not detected

# Default value for keep_releases is 5
set :keep_releases, 5

# If you need to touch public/images, public/javascripts, and public/stylesheets on each deploy
set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}

# Defaults to 'db'
set :migration_role, 'migrator'

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end

namespace :rake do
  desc "Invoke rake task"
  task :invoke do
    run "cd #{deploy_to}/current"
    run "bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}"
  end
end
