# Author: SIEM Team
# Objective: Generate a text file with x example logs for splunk.
# Name: geradorLogs
# Version: 1

import sys
import getpass
import random
from datetime import datetime
import os

#Grabbing how many log lines the user wants.
lines = int(sys.argv[1])

#Creating the log body constants
constant1 = ',"True","ForcePoint Service","svc.forcepoint","CN=ForcePoint Service,CN=Users,DC=ve,DC=CONTOSO,DC=grupo","12/11/2019 09:15:28","12/11/2019 09:12:45","True"'
constant2 = ',"True","ForcePoint Service","svc.forcepoint","CN=ForcePoint Service,CN=Users,DC=ve,DC=CONTOSO,DC=grupo","12/11/2019 09:15:27","12/11/2019 09:12:45","True"'
constant3 = ', "NTBACBR257","12/11/2019 07:21:24","Windows 8.1 Pro","vs.CONTOSO.grupo/AR/Bragado/Bragado Computers/NTBACBR257","CN=NTBACBR257,OU=Bragado Computers,OU=Bragado,OU=AR,DC=vs,DC=CONTOSO,DC=grupo","02/12/2019 08:12:45","4096","True"'
constant4 = ', "NTBACBR257","12/11/2019 07:21:24","Windows 8.1 Pro","vs.CONTOSO.grupo/AR/Bragado/Bragado Computers/NTBACBR257","CN=NTBACBR257,OU=Bragado Computers,OU=Bragado,OU=AR,DC=vs,DC=CONTOSO,DC=grupo","02/12/2019 08:15:40","4096","True"'
constant5 = ', "NTBACBR257","12/11/2019 07:21:24","Windows 8.1 Pro","vs.CONTOSO.grupo/AR/Bragado/Bragado Computers/NTBACBR257","CN=NTBACBR257,OU=Bragado Computers,OU=Bragado,OU=AR,DC=vs,DC=CONTOSO,DC=grupo","02/12/2019 09:12:40","4096","True"'

#Grabbing PC's Username
username = getpass.getuser()

#Creating a new directory and a log file in which the logs will be stored
try:
		os.makedirs("/Users/" + username + "/Documents/Forno")
except:
		print("")
		
f = open("/Users/" + username + "/Documents/Forno/generated_logs.txt","a")

#Loop for each line
for loop in range (0, lines):

		#Grabbing current date and time
		curr_time = datetime.now()
		curr_time = curr_time.strftime('%Y-%m-%d %H:%M:%S.%f')
		curr_time = curr_time[:-3]
		
		#Creating a filter(which is a random number between 1 and 10) that randomizes which log body will be used 
		filter = random.randrange(1,10)
		
		#Appliying the filter
		if filter <= 2:
				print('"' + curr_time + '"' + constant1, file = f)
		elif filter > 2 and filter <= 4:
				print('"' + curr_time + '"' + constant2, file = f)
		elif filter > 4 and filter <= 6:
				print('"' + curr_time + '"' + constant3, file = f)
		elif filter > 6 and filter <= 8:
				print('"' + curr_time + '"' + constant4, file = f)
		elif filter > 8 and filter <= 10:
				print('"' + curr_time + '"' + constant5, file = f)
		
f.close()
