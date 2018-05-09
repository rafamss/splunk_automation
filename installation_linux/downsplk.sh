#!/bin/bash

# Start the checklist to download Splunk Enterprise
cd ~/
mkdir -p downloads && cd $_
if [ ! -x /usr/bin/wget ] ; then
   sudo yum install wget -y
else
   echo "################## wget encontra-se instalado previamente.##################"
fi

# Baixar do repositório remoto
wget -O splunk-7.1.0-2e75b3406c5b-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.1.0&product=splunk&filename=splunk-7.1.0-2e75b3406c5b-Linux-x86_64.tgz&wget=true'

# baixar o md5 para validar o download
wget https://download.splunk.com/products/splunk/releases/7.1.0/linux/splunk-7.1.0-2e75b3406c5b-Linux-x86_64.tgz.md5

exit
