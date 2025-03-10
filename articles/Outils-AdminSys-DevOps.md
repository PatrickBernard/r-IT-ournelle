# Outils Adminsys DevOps

## Outils communs

```bash
apt install git vim pipx openssh-client curl
```

## Documentation

```bash
pipx install tldr
```

```bash
curl cheat.sh
```

## Cyberdefense

``pipx install arsenal-cli``

## Infrastructure As Code

### Ansible

```bash
pipx install --include-deps ansible
pipx inject ansible argcomplete
pipx install ansible-lint
```

### OpenTofu

* le script automatique :

```bash
curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
bash install-opentofu.sh --install-method deb
```

* ou manuellement :

```bash
sudo apt install apt-transport-https ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://get.opentofu.org/opentofu.gpg | sudo tee /etc/apt/keyrings/opentofu.gpg >/dev/null
curl -fsSL https://packages.opentofu.org/opentofu/tofu/gpgkey | sudo gpg --no-tty --batch --dearmor -o /etc/apt/keyrings/opentofu-repo.gpg >/dev/null
sudo chmod a+r /etc/apt/keyrings/opentofu.gpg /etc/apt/keyrings/opentofu-repo.gpg
sudo apt update
sudo apt install tofu
```

## Conteneurisation

* incus
* docker
