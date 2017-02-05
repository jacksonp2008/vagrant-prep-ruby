#
# Cookbook Name:: vagrant-prep-ruby
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#
# Ensure system apt-cache is up to date
include_recipe 'apt::default'

include_recipe 'ntp::default'

# Install packages
node['bootstrap_packages'].each do |pkg|
    package pkg
end

# This includes timezone, hostname and apt-update
include_recipe 'system::default'

# Install RVM
execute 'rvm' do
    user "vagrant"
    cwd "/home/vagrant"
    command ' \curl -L https://get.rvm.io | bash -s stable --ruby'
end

bash 'upates' do
  cwd "/home/vagrant"
  code <<-EOH
    source /home/vagrant/.rvm/scripts/rvm
    gem -v
    rvm gemset use global
    echo "gem: --no-document" >> ~/.gemrc
    gem install bundler
    gem install nokogiri
    EOH
end
