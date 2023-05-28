#!/bin/bash

sudo apt update -y
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null

sudo apt update && sudo apt upgrade -y
sudo apt -y install gnupg2 wget vim bat nano git
 
 #2) Install PostgreSQL 15 Database Server and Client
 
git clone https://github.com/Telxey/MaaS-PostgreSQL.git 
sudo apt install postgresql postgresql-client -y
#sudo -u postgres psql --command '\password'
sudo systemctl enable postgresql
sudo systemctl status postgresql
sudo -u postgres psql -c "SELECT version();"
sudo -u postgres psql -c "SHOW data_directory;"
psql --version
#psql -h localhost -U postgres
cd MaaS-PostgreSQL
cat db-info.md
sudo nano sample-export.md
cat sample-export.md
mv sample-export.md db.sh
bash db.sh


# Create DB
# $MAAS_DBUSER = <db-usr>
# $MAAS_DBPASS = <db-usr-Passwd>
# $MAASDB = <databasename>
# $HOSTNAME = hostname

# WARNING you have to escape special characters for the password

sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"
sudo -u postgres createdb -O $MAASDBUSER $MAASDB
sudo -u postgres psql --command '\l'
sudo -u postgres psql --command '\du'
sudo -u postgres psql --command '\q'
sudo nano /etc/postgresql/15/main/postgresql.conf
sudo nano /etc/postgresql/15/main/pg_hba.conf


sudo rm -rf MaaS-PostgreSQL 
sudo rm install-DB.sh

