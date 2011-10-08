# Look here for cleanup/refactoring ideas: http://github.com/leehambley/railsless-deploy/
load 'deploy' if respond_to?(:namespace) # cap2 differentiator

set :application, "server_extras"
set :deploy_to, "/data/apps/extras"

set :scm, :git
set :repository, "git://github.com/gcao/#{application}.git"

set :normalize_asset_timestamps, false

if ENV['DEPLOYMENT_TARGET'] == 'production'
  set :user, "root"
  set :use_sudo, false

  ami_host = `ami_host`.strip

  # AMI ami-0d729464: ubuntu 9.04 server base 
  server ami_host, :all, :primary => true
else
  set :user, "vagrant"
  set :use_sudo, true

  server 'vagrant', :app, :web, :db, :primary => true
end

