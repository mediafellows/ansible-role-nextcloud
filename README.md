[![Ansible-Test](https://github.com/mediafellows/ansible-role-nextcloud/actions/workflows/ansible_test.yml/badge.svg)](https://github.com/mediafellows/ansible-role-nextcloud/actions/workflows/ansible_test.yml)

# Ansible Role for Nextcloud Server setup

Ansible Role that sets up Nextcloud with Nginx and PHP on an Ubuntu/Debian server. Designed to not handle DB install and HTTPS setup. So this role is uesefull when running 
behind a Loabalancer that takes care of HTTPs termination already. Also if you want to run your DB on another host, this role doesn't preinstall a DB for you.

If you want to setup a DB on that host just use another Ansible role for Postgres or MySQL. For example there is [mediafellows.postgresql](https://github.com/mediafellows/ansible-role-postgresql).

This role installs PHP dependencies and  installs the PHP runner FastCGI Process Manager ([FPM](https://www.php.net/manual/de/install.fpm.php)).
It also utilizes [mediafellows.nginx](https://github.com/mediafellows/ansible-role-nginx) role for installing Ngxinx as a Websterver.

## Requirements

Linux Distribution with apt package manager. Ideally newer versions (like Ubuntu 18.04) that provide php7.2 as part of their repos.

## Role Variables

Role variables that make sense to override to your needs (shows default settings here):

- `nextcloud_version: 31.0.5` - Nextcloud version to install, pick one that can be downloaded from download server already
- `nextcloud_php_version: 8.4` - PHP version to install
- `nextcloud_db_type: pgsql` - DB type to use for Nextcloud. Either 'mysql', 'pgsql' (for Postgres) or 'sqlite' (untested).
- `nextcloud_db_user: nextcloud` - User for connecting to DB
- `nextcloud_db_pass: 1231231` - PW for DB access
- `nextcloud_install_dir: /opt/nextcloud` - Install dir where Nextcloud will be unpacked
- `nextcloud_initial_user_name: admin` - Set username for initial admin user
- `nextcloud_initial_user_pw: 'foobar'` - Set PW for initial admin user for your Nextcloud setup (for first login)

Find more variables in defaults/main.yml

## Dependencies

Depends on the mediafellows.nginx role for setting up the Webserver:

- [mediafellows.nginx](https://github.com/mediafellows/ansible-role-nginx)

## Example Playbook

Example playbook integration

```yaml
- name: Install Nextcloud
  hosts: nextcloud_hosts
  become: true
  vars:
    nextcloud_version: 31.0.5
    nextcloud_install_dir: /opt/nextcloud/
    nextcloud_initial_user_name: admin
    nextcloud_initial_user_pw: abc123abc
    nextcloud_db_pass: 'nextcloud-db-pw'
  roles:
    - mediafellows.nextcloud
```

## License

BSD

## Author Information

Stefan Horning <stefan.horning@mediafellows.com>
