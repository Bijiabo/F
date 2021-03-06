desc "config rails bundle"
task :bundle_install do
  on roles(:all) do |h|
    if test("env | grep SSH_AUTH_SOCK")
      info "Agent forwarding is up to #{h}"
    else
      error "Agent forwarding is NOT up to #{h}"
    end
  end
end

desc "Run rake task on server"
task :rake do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      as :deploy do
        with rails_env: :production do
          execute :rake, ENV['task'], "RAILS_ENV=production"
        end
      end
    end
  end
end

desc "Install app dependencies"
task :install_dependencies do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      as :deploy do
        with rails_env: :production do
          execute 'bundle', 'install', '--deployment', '--without', 'development', 'test'
        end
      end
    end
  end
end

desc "Compile Rails assets and run database migrations"
task :compile_rails_assets_and_run_database_migrations do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      as :deploy do
        with rails_env: :production do
          execute 'bundle', 'exec', 'rake', 'assets:precompile', 'db:migrate', 'RAILS_ENV=production'
        end
      end
    end
  end
end

desc "reatart passenger"
task :restart_passenager do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      as :deploy do
        with rails_env: :production do
          execute 'passenger-config', 'restart-app', '/home/deploy/project/ruby/NC/current'
        end
      end
    end
  end
end