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
app_user        = "vagrant"
app_name        = 'ttt-ruby'
app_home        = user_home + app_name
ruby_version    = '2.2.2'
ruby_path       = user_home + '.rubies/' + ruby_version

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

git app_home do
  repository "git@github.com:hanster/tic-tac-toe-web.git"
  reference "master"
  user app_user
  action :sync
end

%w[build-essential bison openssl libreadline6 libreadline6-dev
  zlib1g zlib1g-dev libssl-dev libyaml-dev].each do |p|
    package p
  end

ruby_build_ruby ruby_version do
  prefix_path ruby_path
  environment 'RUBY_CONFIGURE_OPTS' => '--disable-install-doc'
  user app_user
  group app_user
end

link "/usr/bin/ruby" do
  to ruby_path + "/bin/ruby"
end

#
#gem_package "bundler"
#
#bash "install dependencies" do
#  user app_user
#  cwd app_home
#  code "bundle install --path=vendor/bundle"
#end

