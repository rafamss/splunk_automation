#!/bin/bash

# Start the checklist to download Splunk Enterprise
cd ~/
mkdir -p downloads && cd $_
echo -e "################## validating if wget is installed ##################\n"

# Validating if the wget command are installed
if [ ! -x /usr/bin/wget ] ; then
	echo -e "################## wget not installed, installing now ... ##################\n"
	# At this moment just Linux using yum package manager are ready to use
	sudo yum install wget -y
else
	echo -e "################## wget was already installed ##################\n"
fi

# Remote download of Splunk Enterprise from the specified repository
wget -O splunkenterprise 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.1.0&product=splunk&filename=splunk-7.1.0-2e75b3406c5b-Linux-x86_64.tgz&wget=true'

# Remote download from the specified repository of md5 validation file
wget -O splunkenterprisemd5 https://download.splunk.com/products/splunk/releases/7.1.0/linux/splunk-7.1.0-2e75b3406c5b-Linux-x86_64.tgz.md5

#validate downloaded files of Splunk Enterprise

md5sum splunkenterprise splunkenterprisemd5 > splunkvalidatemd5

if md5sum --status -c splunkvalidatemd5 ; then
	# The MD5 sum matched
		echo -e "splunkenterprise md5 matched\n"
else
	# The MD5 sum didn't match
		echo -e "splunkenterprise md5 didn't match\n"
fi

echo -e "splunk enterprise downloaded and ready to install\n"

exit