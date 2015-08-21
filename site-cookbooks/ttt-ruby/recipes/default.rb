#
# Cookbook Name:: ttt-ruby
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user_home       = node['ttt-ruby']['web_app']['user_home']
user_name       = node['ttt-ruby']['web_app']['user_name']
app_git_repo    = 'git@github.com:hanster/tic-tac-toe-web.git'
app_name        = 'ttt-ruby'
app_home        = user_home + app_name
thin_pid_file   = 'tmp/pids/thin.pid'

directory user_home do
  owner user_name
  group user_name
  mode 0755
  action :create
  recursive true
end

directory File.join(user_home, '.ssh') do
  owner user_name
  group user_name
  mode 0755
  action :create
  recursive true
end

package 'git'

ssh_known_hosts 'github.com' do
  hashed true
  user user_name
end

bash "stop the server" do
  user user_name
  cwd app_home
  code "/usr/local/bin/chruby-exec 2.2.2 -- 'bundle exec thin -P #{thin_pid_file} stop'"
  only_if { File.exists? app_home + '/' + thin_pid_file }
end

git app_home do
  repository app_git_repo
  reference "master"
  user user_name
  action :sync
end

bash "install bundler" do
  user user_name
  code "/usr/local/bin/chruby-exec 2.2.2 -- 'gem install bundler'"
end

bash "install dependencies" do
  user user_name
  cwd app_home
  code "/usr/local/bin/chruby-exec 2.2.2 -- 'bundle install'"
end

bash "run the server" do
  user user_name
  cwd app_home
  code "/usr/local/bin/chruby-exec 2.2.2 -- 'bundle exec thin -P #{thin_pid_file} -l logs/thin.log -d start'"
end

