#!/bin/bash

##########################
# @author: Rafael Santos #
# @description: This script download the Splunk Enterprise file
# your md5 hash file and them validate both.
# @optional: You can set the variables to your own environment
# See the ## Variables definition ##
##########################

## Variables definition ##
## Set of URL download ###
URL_download='https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.1.1&product=splunk&filename=splunk-7.1.1-8f0ead9ec3db-Linux-x86_64.tgz&wget=true'
URL_md5validation='https://download.splunk.com/products/splunk/releases/7.1.1/linux/splunk-7.1.1-8f0ead9ec3db-Linux-x86_64.tgz.md5'

## Set directory to downdload splunk and validate then ##
## Change this if you want to ##
dctdown='/home/'$USER

# Start the checklist to download Splunk Enterprise
cd $dctdown
mkdir -p downloads && cd $_

# Validating if the wget command are installed
echo -e "################## validating if wget is installed ##################\n"
if [ ! -x /usr/bin/wget ] ; then
	echo -e "################## wget not installed, installing now ... ##################\n"
	# At this moment just Linux using yum package manager are ready to use
	sudo yum install wget -y
else
	echo -e "################## wget was already installed ##################\n"
fi

# Remote download of Splunk Enterprise from the specified repository
# This URL download can be set at URL_download
wget -O splunkenterprise.tgz $URL_download

# Remote download from the specified repository of md5 validation file
# This URL download can be set at URL_md5validation
wget -O splunkenterprise.tgz.md5 $URL_md5validation

# Validating the downloaded files of Splunk Enterprise #

md5sum splunkenterprise.tgz splunkenterprise.tgz.md5 > splunkhashvalidate.md5

if md5sum --status -c splunkhashvalidate.md5 ; then
	# The MD5 sum matched
	echo -e "splunkenterprise.tgz md5 matched\n"
else
	# The MD5 sum didn't match
	echo -e "splunkenterprise.tgz md5 didn't match\n"
fi

echo -e "splunk enterprise downloaded and ready to install :)\n"

exit
