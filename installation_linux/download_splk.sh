#!/bin/bash

##########################################################################################################
# @author: Rafael Santos
# @description: This script download the Splunk Enterprise file your md5 hash file and them validate both.
# @optional: You can set the variables to your own environment in ## Variable Section ##
##########################################################################################################

##########################################################################################################
# To see more information about Splunk's Enterprise old versions, Please see the old_versions.txt file!
##########################################################################################################

## Variable Section ######################################################################################

### Linux Codename based in your base Linux like Debian and REHL
codename=$(cat /etc/os-release | grep "ID_LIKE" | sed 's/ID_LIKE=//g' | sed 's/["]//g' | awk '{print $1}')
### Directory used to download, copy and validate Splunk Enterprise image ###
dctdown='/home/'$USER
### Last version of Splunk Enterprise - You could put the necessary URL here, i.e. (Go to old_versions.txt file and get the version that you want to)
### Splunk Enterprise URL to download ###
url_download='https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.2.0&product=splunk&filename=splunk-7.2.0-8c86330ac18-Linux-x86_64.tgz&wget=true'
### Splunk Enterprise Version - It is not necessary change this variable ###
splunk_version=$(echo $url_download | grep -Po '(?<=version\=)\d{1}\.\d{1}\.\d{1}')
### Splunk Enterprise MD5 File Validation ###
url_md5validation='https://download.splunk.com/products/splunk/releases/7.2.0/linux/splunk-7.2.0-8c86330ac18-Linux-x86_64.tgz.md5'

#######################################################################################################
## - First: Open the download directory configured ($dctdown), create a download folder and get in that
#######################################################################################################

cd $dctdown
mkdir -p downloads && cd $_

#######################################################################################################
## - Second: Test to if wget command is installed, if not install wget
#######################################################################################################

echo -e "########### validating if wget is installed #################"

if [ ! -x /usr/bin/wget } && [ $codename="rhel" ] ; then
    echo -e "########### wget is not installed, installing ###############"
	sudo yum install wget -y
if [ ! -x /usr/bin/wget ] && [ $codename=="ubuntu" ] ; then
    echo -e "########### wget is not installed, installing ###############"
    sudo apt-get install wget -y
else
	echo -e "########### wget is already, installed ######################"
fi

#######################################################################################################
## - Third: Download Splunk Enterprise and your MD5 Validation File 
#######################################################################################################

echo -e "########### Start the Splunk's Enterprise Download Version $splunk_version ###############"
wget -O splunkenterprise.tgz $url_download
echo -e "########### Start the Splunk's Enterprise $splunk_version MD5 Validation File Download ###############"
wget -O splunkenterprise.tgz.md5 $url_md5validation

#######################################################################################################
## - Fourth: Validate Splunk Enterprise and your MD5 Validation File 
#######################################################################################################

md5sum splunkenterprise.tgz splunkenterprise.tgz.md5 > splunkhashvalidate.md5

if [ md5sum --status -c splunkhashvalidate.md5 ] ; then
	# The MD5 sum match
    echo -e "Splunk Enterprise Version: $splunk_version downloaded and validate, now It's ready to install :)\n"
else
	# The MD5 sum doesn't match
	echo -e "The Splunk Enteprise File and your MD5 Validation File doesn't match ;(, please try again"
fi

exit