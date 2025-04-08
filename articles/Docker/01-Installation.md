# Installation Docker

## En ligne de commande

src: <https://docs.docker.com/engine/install/debian/>

```bash
# uninstall all conflicting packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Via un role ansible

todo : instalation ansible et les roles ansible-galaxy

Etant un adepte d'ansible il existe un role très bien fait pour installer et paramettrer un noeud docker.

src : <https://galaxy.ansible.com/ui/standalone/roles/geerlingguy/docker>

```yml
---
- name: Install docker for user
  hosts:
    - machine-docker.local
  roles:
    - role: geerlingguy.docker
      become: true
      vars:
        docker_install_compose_plugin: "{{ ansible_os_family == 'Debian' }}"
        docker_users:
          - user

```

## Proxmox : community script

Dans le repos Proxmox community script il y a plusieurs script pour directement créer un lxc ou une vm docker

src : <https://community-scripts.github.io/ProxmoxVE/scripts?id=docker>

Exemple : A lancer directement sur le noeud proxmox pour créer un conteneur lxc debian avec docker préinstaller

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/docker.sh)"
```

## Premier test

- Lancer un conteneur : ``docker run nginx:latest``
on aura la sortie de log sur l'écran (ctrl+c pour reprendre la main)
- Lister les conteneurs actif : ``docker ps``
- Lister tout les conteneurs : ``docker ps -a``
- Lancer un conteneur en arriere plan : ``docker run -d nginx:latest``
