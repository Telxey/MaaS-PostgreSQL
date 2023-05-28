#!/bin/bash

sudo apt update -y
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null

sudo apt update && sudo apt upgrade -y
sudo apt -y install gnupg2 wget vim bat nano git
 
 #2) Install PostgreSQL 15 Database Server and Client
 
git clonehttps://github.com/Telxey/MaaS-PostgreSQL.git 
sudo apt install postgresql postgresql-client -y
#sudo -u postgres psql --command '\password'
sudo systemctl enable postgresql
sudo systemctl status postgresql
sudo -u postgres psql -c "SELECT version();"
sudo -u postgres psql -c "SHOW data_directory;"
psql --version
#psql -h localhost -U postgres
cd MaaS-PostgreSQL
sudo nano export.sh
bash export.sh
cd ..

rm -r MaaS-PostgreSQL && rm install-DB.sh

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

