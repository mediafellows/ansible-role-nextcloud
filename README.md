# Ansible Role for Nextcloud Server setup

Ansible Role that sets up Nextcloud (with Nginx) on an Ubuntu/Debian server. Unlike other Ansible roles for Nextcloud this role doesn't install any Databases.

This role installs PHP debendencies and  installs the PHP runner FastCGI Process Manager ([FPM](https://www.php.net/manual/de/install.fpm.php)).
It also utilizes [mediafellows.nginx](https://github.com/mediafellows/ansible-role-nginx) role for installing Ngxinx as a Websterver.

For installing other webservers, databases etc use other roles, such as
- [mediafellows.postgresql](https://github.com/mediafellows/ansible-role-postgresql)

Or any other Role that fits your needs (like MySQL, MariaDB, Redis or other PosgreSQL roles).
This also allows for you to run Databases like Relational DB and Redis on other hosts for example. Which would be common if you have managed DBs in a cloud environment.

## Requirements

Linux Distribution with apt package manager. Ideally newer versions (like Ubuntu 18.04) that provide php7.2 as part of their repos.

## Role Variables

Role variables that make sense to override to your needs (shows default settings here):

- `nextcloud_install_dir: /opt/nextcloud` - Install dir where Nextcloud will be unpacked
- `nextcloud_version: 19.0.0` - Nextcloud version to install, pick one that can be downloaded from download server already
- `nextcloud_php_version: php7.2` - PHP version to install. Ensure this version is in the apt repo of your distro already (this role won't add any additional repos)

Find more variables in defaults/main.yml

## Dependencies

Depends on the mediafellows.nginx role for setting up the Webserver:

- [mediafellows.nginx](https://github.com/mediafellows/ansible-role-nginx)

## Example Playbook

Example playbook integration

```yaml
- name: Install Nextcloud
  hosts: nextcloud_hosts
  vars:
    nextcloud_version: 19.0.0
    nextcloud_install_dir: /opt/nextcloud/
  roles:
    - mediafellows.nextcloud
```

## License

BSD

## Author Information

Stefan Horning <stefan.horning@mediafellows.com>
