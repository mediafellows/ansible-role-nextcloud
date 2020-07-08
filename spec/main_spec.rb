require 'spec_helper'

describe 'Nginx setup' do
  nginx_conf_dir = '/etc/nginx'

  describe file("#{nginx_conf_dir}/nginx.conf") do
    it { should be_file }
  end

  describe file("#{nginx_conf_dir}/sites-available/") do
    it { should be_directory }
    it { should be_owned_by('root') }
    it { should be_grouped_into('www-data') }
  end

  describe file("#{nginx_conf_dir}/sites-enabled/") do
    it { should be_directory }
    it { should be_owned_by('root') }
    it { should be_grouped_into('www-data') }
  end

  describe file("#{nginx_conf_dir}/sites-enabled/nextcloud.conf") do
    it { should be_file }
  end

  describe service("nginx") do
    it { should be_running }
  end
end

describe 'Nextcloud setup' do
  describe file('/opt/nextcloud') do
    it { should be_directory }
    it { should be_owned_by('www-data') }
    it { should be_grouped_into('www-data') }
  end

  describe file('/opt/nextcloud/config/config.php') do
    it { should be_file }
    it { should be_owned_by('root') }
    it { should be_grouped_into('root') }
  end

  describe service("php7.4-fpm") do
    it { should be_running }
  end
end
