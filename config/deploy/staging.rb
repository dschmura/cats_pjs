
  server 'lsa-mis-rails-staging.miserver.it.umich.edu', user: 'deployer', roles: %w{app db web}
  set :stage, :staging
  set :branch, :master
  set :deploy_user, "deployer"
  set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/cats_pjs"
  set :branch, 'master'
  set :rails_env, 'staging'
  set :puma_env, "staging"
  set :puma_conf, "#{shared_path}/config/puma.rb"
