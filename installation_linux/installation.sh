#!/bin/bash

# opening the directory of download
cd ~/downloads

# untar the validated splunk enterprise file
sudo tar -zxvf splunkenterprise.tgz -C /opt

# define the user and group of splunk directory owner
user=[your user]
pass=[your pass]

# change the owner of installation directory
sudo chown -R $user:$pass /opt/splunk

# puting the user credentials at the user-seed.conf
cd /opt/splunk/etc/system/local
touch user-seed.conf
echo [user_info] > user-seed.conf
echo USERNAME=admin >> user-seed.conf
echo PASSWORD=changeme  >> user-seed.conf

# starting the splunk without answer any questions
# the admin user will be created below at this script
./bin/splunk start --answer-yes --no-prompt --accept-license

# put the splunk in boot start
./splunk enable boot-start

# setting the Splunk Home
export SPLUNK_HOME='/opt/splunk'