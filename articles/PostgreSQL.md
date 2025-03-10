# PostgreSQL

## Install PG

Je préfère utiliser les paquets issu de Postgresql pour debian/ubuntu

### Configuration du repos

- Create the file repository configuration

```bash
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
```

- Import the repository signing key

```bash
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
```

- Update the package lists

```bash
sudo apt-get update
```

- Installer la derniere version

```bash
sudo apt-get -y install postgresql
```

Vous pouvez spécifier une version spéficique ``postgresql-12``

## Upgrade PG

- Installer le nouveau pg

```bash
sudo apt-get update
sudo apt-get install postgresql-15 postgresql-server-dev-15
```

- vérifier et reporter les différences de configuration si nécessaire

```bash
diff /etc/postgresql/14/main/postgresql.conf /etc/postgresql/15/main/postgresql.conf
diff /etc/postgresql/14/main/pg_hba.conf /etc/postgresql/15/main/pg_hba.conf
```

- stop pg

```bash
sudo systemctl stop postgresql.service
```

- check cluster

```bash
sudo su - postgres
/usr/lib/postgresql/15/bin/pg_upgrade \
  --old-datadir=/var/lib/postgresql/14/main \
  --new-datadir=/var/lib/postgresql/15/main \
  --old-bindir=/usr/lib/postgresql/14/bin \
  --new-bindir=/usr/lib/postgresql/15/bin \
  --old-options '-c config_file=/etc/postgresql/14/main/postgresql.conf' \
  --new-options '-c config_file=/etc/postgresql/15/main/postgresql.conf' \
  --check
```

- migration

```bash
/usr/lib/postgresql/15/bin/pg_upgrade \
  --old-datadir=/var/lib/postgresql/14/main \
  --new-datadir=/var/lib/postgresql/15/main \
  --old-bindir=/usr/lib/postgresql/14/bin \
  --new-bindir=/usr/lib/postgresql/15/bin \
  --old-options '-c config_file=/etc/postgresql/14/main/postgresql.conf' \
  --new-options '-c config_file=/etc/postgresql/15/main/postgresql.conf'
```

- échanger les ports des deux serveurs

  - change de "port = 5433" à "port = 5432"

  ```bash
  sudo vim /etc/postgresql/15/main/postgresql.conf
  ```

  - change de "port = 5432" à "port = 5433"

  ```bash
  sudo vim /etc/postgresql/14/main/postgresql.conf
  ```

- start PG

```bash
sudo systemctl start postgresql.service
```

- check

```bash
sudo su - postgres
psql -c "SELECT version();"
```

- il est recommandé de lancer un vaccum

```bash
/usr/lib/postgresql/15/bin/vacuumdb --all --analyze-in-stages
```

- nettoyage

```bash
sudo apt-get remove postgresql-14 postgresql-server-dev-14
sudo rm -rf /etc/postgresql/14/
sudo su - postgres
./delete_old_cluster.sh
```
