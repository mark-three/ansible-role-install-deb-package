# ansible-role-install-deb-package

Role to download a debian package (.deb) from a URL and install the package, as well as configured dependencies.

## Distros tested

* Debian 12

## Dependencies

* Ansible
* APT based Linux Distro


## Default Settings

```yaml
---
# Display name
deb_package_display_name: "Deb Package Display Name"

# Used to query if the package is installed with dpkg-query -W {{ deb_package_name }}
deb_package_name: deb_package_name

# URL of the package to download
deb_package_url: deb_package_url

# Package file name default assumes the URL points to latest version
deb_package_file_name: "{{ deb_package_name }}-latest.deb"

# List of dependencies to install before the deb package
deb_package_dependencies: []

# Update the package, if it is already installed
update_package: false

# Default download paths for deb package
dest_folder_path: /tmp/ansible/deb
dest_file_path: "{{ dest_folder_path }}/{{ deb_package_file_name }}"
```

## Install Role locally

### Create requirements.yml
```yaml
---
- src: https://github.com/mark-three/ansible-role-install-deb-package
  scm: git
  version: main
  name: mark-three.install_deb_package
```

### Install requirements locally
```bash
ansible-galaxy install -r requirements.yml
```

## Example Playbook install-deb-packages.yml

```yaml
---
- name: Download and install third-party deb packages playbook
  become: true
  roles:
    - role: install-deb-package
      vars:
        deb_package_display_name: "Discord"
        deb_package_name: discord
        deb_package_url: https://discord.com/api/download?platform=linux&format=deb
        update_package: true
        # Note curl is not a dependency of discord, left as an example
        deb_package_dependencies:
          - curl

    - role: install-deb-package
      vars:
        deb_package_display_name: "Beyond Compare"
        deb_package_name: bcompare
        deb_package_url: https://www.scootersoftware.com/files/bcompare-4.4.7.28397_amd64.deb

    - role: mark-three.install_deb_package
      vars:
        deb_package_display_name: "Beyond Compare"
        deb_package_name: bcompare
        deb_package_url: https://www.scootersoftware.com/files/bcompare-4.4.7.28397_amd64.deb
```

## Prep

* install ansible
* create playbook with debian packages to download and install
* run ansible commands

## Usage

Download and install all packages

```bash
ansible-playbook install-deb-packages.yml
```
