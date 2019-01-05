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
url_download='https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.2.0&product=splunk&filename=splunk-7.2.0-8c86330ac18-Linux-x86_64.tgz&wget=true'
### Splunk Enterprise Version - It is not necessary change this variable ###
splunk_version=$(echo $url_download | grep -Po '(?<=version\=)\d{1}\.\d{1}\.\d{1}')
### Splunk Enterprise MD5 File Validation ###
url_md5validation='https://download.splunk.com/products/splunk/releases/7.2.0/linux/splunk-7.2.0-8c86330ac18-Linux-x86_64.tgz.md5'

#######################################################################################################
## - Thankful Notes
#######################################################################################################
echo -e "\032[31;1;4mThankful to use this code, if you want to contribute with this, just ask for a pull request :)\033[0m"

#######################################################################################################
## - First: Open the download directory configured ($dctdown), create a download folder and get in that
#######################################################################################################
echo -e "\034[31;1;4mCreating directory base and opening it\033[0m"
cd $dctdown
mkdir -p splunk_tmp && cd $dctdown

#######################################################################################################
## - Second: Test to if wget command is installed, if not install wget
#######################################################################################################
echo -e "\034[31;1;4mValidating if wget is installed\033[0m"

if [ ! -x /usr/bin/wget ] && [ $codename="rhel" ] ; then
	echo -e "\033[31;1;4mWget is not installed, let's do this\033[0m"
	sudo yum install wget -y
elif [ ! -x /usr/bin/wget ] && [ $codename="ubuntu" ] ; then
	echo -e "\033[32;1;4mWget is not installed, let's do this\033[0m"
	sudo apt-get install wget -y
else
	echo -e "\032[31;1;4mWget is already installed, let's go the next step\033[0m"
fi

#######################################################################################################
## - Third: Download Splunk Enterprise and your MD5 Validation File 
#######################################################################################################
echo -e "\034[31;1;4mStart the Splunk's Enterprise Download Version $splunk_version\033[0m"
wget -O splunkenterprise.tgz $url_download
echo -e "\034[31;1;4mStart the Splunk's Enterprise $splunk_version MD5 Validation File Download\033[0m"
wget -O splunkenterprise.tgz.md5 $url_md5validation

#######################################################################################################
## - Fourth: Validate Splunk Enterprise and your MD5 Validation File 
#######################################################################################################
echo -e "\034[31;1;4mCreating a HashFile (Splunk Enteprise and your MD5 File) to Compare them\033[0m"
md5sum splunkenterprise.tgz splunkenterprise.tgz.md5 > splunkhashvalidate.md5

if [ md5sum --status -c splunkhashvalidate.md5 ] ; then
	# The MD5 sum match
	echo -e "\032[32;1;4mSplunk Enterprise Version: $splunk_version downloaded and validate, now It's ready to install :)\033[0m"
else
	# The MD5 sum doesn't match
	echo -e "\033[31;1;4mHum! Splunk Enteprise File and your MD5 Validation File doesn't match ;(, please try again\033[0m"
fi

exit
