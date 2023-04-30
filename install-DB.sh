#!/bin/bash

sudo apt update -y
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null

sudo apt update && sudo apt upgrade -y
sudo apt -y install gnupg2 wget vim bat nano
 
 #2) Install PostgreSQL 15 Database Server and Client
 
sudo apt install postgresql postgresql-client -y
#sudo -u postgres psql --command '\password'
sudo systemctl enable postgresql
sudo systemctl status postgresql
sudo -u postgres psql -c "SELECT version();"
sudo -u postgres psql -c "SHOW data_directory;"
psql --version
#psql -h localhost -U postgres
rm install-DB.sh

# Create DB
# $MAAS_DBUSER = Tabasco4313
# $MAAS_DBPASS = 4vhjvadnhifchy9p
# $MAAS_DBNAME = Payback6699
# $HOSTNAME = pg.f4c1l.com

export MAASDB=maasdb
export MAASDBUSER=Tabasco4313
# WARNING you have to escape special characters for the password
export MAASDBUSERPASSWORD=4vhjvadnhifchy9p
export HOSTNAME=pg.f4c1l.com
sudo -u postgres psql -c "CREATE USER \"$MAASDBUSER\" WITH ENCRYPTED PASSWORD '$MAASDBUSERPASSWORD'"
sudo -u postgres createdb -O $MAASDBUSER $MAASDB
sudo -u postgres psql --command '\l'
sudo -u postgres psql --command '\du'
sudo -u postgres psql --command '\q'
sudo nano /etc/postgresql/15/main/postgresql.conf
sudo vi /etc/postgresql/15/main/pg_hba.conf

#add lines 
# host    maasdb          maasdbuser      172.30.0.0/16           md5
# host    replication     maasdbrep       172.30.0.0/16           md5
# host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5
# 
