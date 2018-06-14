#!/usr/bin/env puma

directory '/home/deployer/apps/cats_pjs/current'
rackup "/home/deployer/apps/cats_pjs/current/config.ru"
environment 'production'

pidfile "/home/deployer/apps/cats_pjs/shared/tmp/pids/puma.pid"
state_path "/home/deployer/apps/cats_pjs/shared/tmp/pids/puma.state"
stdout_redirect '/home/deployer/apps/cats_pjs/current/log/puma.error.log', '/home/deployer/apps/cats_pjs/current/log/puma.access.log', true

threads 4,16

bind 'unix:///home/deployer/apps/cats_pjs/shared/tmp/sockets/cats_pjs-puma.sock'

workers 0

preload_app!
on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/deployer/apps/cats_pjs/current/Gemfile"
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
