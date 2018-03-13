	######################################################################################################
	LIS upgrade script - The goal of this script is to upgrade LIS drivers to 4.2 version
	######################################################################################################

#########################
How to
#########################

1) Switch to root user account on Linux server (hosted on Azure), where you want to upgrade the LIS drivers to 4.2

2) wget https://raw.githubusercontent.com/linuxelf001/LIS-4.2/master/upgrade.sh; chmod u+x upgrade.sh; ./upgrade.sh

3) Once installation is successful, reboot the server

################################################
STATUS:	DEPRECTED IN FAVOR TO BELOW INSTRUCTIONS
################################################

curl -L https://aka.ms/lis | tar xz 
cd LISISO
sudo ./upgrade.sh

