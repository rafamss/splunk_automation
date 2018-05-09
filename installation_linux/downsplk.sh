#!/bin/bash

# Start the checklist to download Splunk Enterprise
cd ~/
mkdir -p downloads && cd $_

echo "###################################################################"
echo "################## validate if wget is installed ##################"
echo "###################################################################"

if [ ! -x /usr/bin/wget ] ; then
	sudo yum install wget -y
else
	echo "###################################################################"
	echo "################## wget is installed ##################"
	echo "###################################################################"
fi

# Remote download of Splunk Enterprise from the specified repository
wget -O splunk-7.1.0-2e75b3406c5b-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.1.0&product=splunk&filename=splunk-7.1.0-2e75b3406c5b-Linux-x86_64.tgz&wget=true'

# Remote download from the specified repository of md5 validation file
wget https://download.splunk.com/products/splunk/releases/7.1.0/linux/splunk-7.1.0-2e75b3406c5b-Linux-x86_64.tgz.md5

exit
