#!/bin/bash

# change the owner of installation directory
sudo chown -R ec2-user:ec2-user /opt/splunk 

# open the default installation directory
cd /opt/splunk

# starting the splunk without answer any questions
# the admin user will be created below at this script
./bin/splunk start --answer-yes --no-prompt --accept-license

# put the splunk in boot start
./splunk enable boot-start

# setting the Splunk Home
export SPLUNK_HOME='/opt/splunk'

# creating the admin user
cd $SPLUNK_HOME
./bin/splunk stop

# puting the user credentials at the user-seed.conf
cd $SPLUNK_HOME/etc/system/local
touch user-seed.conf
echo > [user_info]
echo >> USERNAME=admin
echo >> PASSWORD=changeme