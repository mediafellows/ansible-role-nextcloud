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
  install_dir = ANSIBLE_VARS.fetch('nextcloud_install_dir', 'UNDEFINED')
  data_dir = ANSIBLE_VARS.fetch('nextcloud_data_dir', 'UNDEFINED')
  nextcloud_db_user = ANSIBLE_VARS.fetch('nextcloud_db_user', 'UNDEFINED')
  nextcloud_user = 'www-data'
  nextcloud_group = 'www-data'

  describe file(install_dir) do
    it { should be_directory }
    it { should be_owned_by(nextcloud_user) }
    it { should be_grouped_into(nextcloud_group) }
  end

  describe file(data_dir) do
    it { should be_directory }
    it { should be_owned_by(nextcloud_user) }
    it { should be_grouped_into(nextcloud_group) }
  end

  describe file("#{install_dir}/config/config.php") do
    it { should be_file }
    its(:content) { should include("'dbhost' => 'localhost:5432'") }
    its(:content) { should include("'dbname' => 'nextcloud'") }
    # its(:content) { should include("'dbuser' => '#{nextcloud_db_user}'") }
  end

  describe service("php8.4-fpm") do
    it { should be_running }
  end
end
