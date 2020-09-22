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
dctdown='/tmp'
### Last version of Splunk Enterprise - You could put the necessary URL below, i.e. (Go to old_versions.txt file and get the version that you want to)
### Splunk Enterprise URL to download ###

url_download='https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.6&product=splunk&filename=splunk-8.0.6-152fb4b2bb96-Linux-x86_64.tgz&wget=true'
### Splunk Enterprise Version - It is not necessary change this variable ###
splunk_version=$(echo $url_download | grep -Po '(?<=version\=)\d{1}\.\d{1}\.\d{1}')
### Splunk Enterprise MD5 File Validation ###
url_md5validation='https://download.splunk.com/products/splunk/releases/8.0.6/linux/splunk-8.0.6-152fb4b2bb96-Linux-x86_64.tgz.md5'

#######################################################################################################
## - Thankful Notes
#######################################################################################################

echo -e "\033[37;1;46m##################################################################################\033[0m"
echo -e "\033[37;1;46;1m Thank you for use this code, if you want to contribute with this, just ask for a pull request :) \033[0m"
echo -e "\033[37;1;46m##################################################################################\033[0m"
echo -e "\n"
sleep 1

#######################################################################################################
## - First: Open the download directory configured ($dctdown), create a download folder and get in that
#######################################################################################################

echo -e "\033[37;1;46m##################################################################################\033[0m"
echo -e "\033[37;1;46;1m Creating directory base and opening it \033[0m"
sleep 2
cd $dctdown
mkdir -p splunk_tmp && cd $_
echo -e "\033[32;1;46;1m Done \033[0m"
echo -e "\033[37;1;46m##################################################################################\033[0m"
echo -e "\n"
sleep 1

#######################################################################################################
## - Second: Test to if wget command is installed, if not install wget
#######################################################################################################

echo -e "\033[37;1;46m##################################################################################\033[0m"
echo -e "\033[37;1;46;1m Validating if wget is installed \033[0m"
sleep 1
if [ ! -x /usr/bin/wget ] && [ $codename="rhel" ] ; then
	echo -e "\033[37;1;46;1m Wget is not installed, let's do this \033[0m"
	sudo yum install wget -y
	echo -e "\033[32;1;46;1m Done \033[0m"
elif [ ! -x /usr/bin/wget ] && [ $codename="ubuntu" ] ; then
	echo -e "\033[37;1;46;1m Wget is not installed, let's do this \033[0m"
	sudo apt-get install wget -y
	echo -e "\033[32;1;46;1m Done \033[0m"
else
	echo -e "\033[37;1;46;1m Wget is already installed, let's go the next step \033[0m"
	echo -e "\033[32;1;46;1m Done \033[0m"
fi
echo -e "\033[37;1;46m##################################################################################\033[0m"
echo -e "\n"
sleep 1

#######################################################################################################
## - Third: Download Splunk Enterprise and your MD5 Validation File 
#######################################################################################################

echo -e "\033[37;1;46m##################################################################################\033[0m"
echo -e "\033[37;1;46;1m Start the Splunk's Enterprise Download Version $splunk_version ...\033[0m"
echo -e "\n"
sleep 1
wget -O splunkenterprise.tgz $url_download
echo -e "\033[32;1;46;1m Done \033[0m"
echo -e "\n"
echo -e "\033[37;1;46;1m Start the Splunk's Enterprise $splunk_version MD5 Validation File Download ...\033[0m"
sleep 1
wget -O splunkenterprise.tgz.md5 $url_md5validation
echo -e "\033[32;1;46;1m Done \033[0m"
echo -e "\033[37;1;46m##################################################################################\033[0m"
echo -e "\n"
sleep 1

#######################################################################################################
## - Fourth: Validate Splunk Enterprise and your MD5 Validation File 
#######################################################################################################

echo -e "\033[37;1;46m##################################################################################\033[0m"
echo -e "\033[37;1;46;1m Creating a Hash File from files to Compare them \033[0m"
sleep 1
md5sum splunkenterprise.tgz splunkenterprise.tgz.md5 > splunkhashvalidate.md5

if md5sum --status -c splunkhashvalidate.md5 ; then
	# The MD5 sum match
	echo -e "\033[32;1;46;1m Everything is right. Splunk Enterprise $splunk_version is ready to install \033[0m"
else
	# The MD5 sum doesn't match
	echo -e "\033[31;1;46;1m Hum! The files doesn't match. Please try again \033[0m"
fi
echo -e "\033[37;1;46m##################################################################################\033[0m"
exit
