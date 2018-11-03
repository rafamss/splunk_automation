#!/bin/bash

# define the user and group of splunk directory owner
user='your user'
group='your pass'

# opening the directory of download
dctdown='/home/'$USER
cd $dctdown/downloads

# untar the validated splunk enterprise file
sudo tar -zxvf splunkenterprise.tgz -C /opt

# change the owner of installation directory
sudo chown -R $user:$group /opt/splunk

# setting the Splunk Home
export SPLUNK_HOME=/opt/splunk
echo SPLUNK_HOME=/opt/splunk >> ~/.bash_profile
source ~/.bash_profile

# puting the new user credentials at the user-seed.conf
cd $SPLUNK_HOME/etc/system/local
touch user-seed.conf
echo [user_info] > user-seed.conf
echo USERNAME=admin >> user-seed.conf
echo PASSWORD=changeme  >> user-seed.conf

# enable Splunk Web access via HTTPS
touch web.conf
echo [settings] > web.conf
echo 'httpport = 8000' >> web.conf
echo 'enableSplunkWebSSL = true'  >> web.conf

# starting the splunk without answer any questions
# the admin user will be created below at this script
cd $SPLUNK_HOME/bin
sudo ./splunk start --answer-yes --no-prompt --accept-license

# put the splunk in boot start
sudo ./splunk enable boot-start

# Reload the profile of user to get the environment variables
source ~/.bash_profile
