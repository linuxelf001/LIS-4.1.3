 +-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+
 |L|I|S| |U|p|g|r|a|d|e| |s|c|r|i|p|t|
 +-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+

The goal of this script is to automatically upgrade the LIS version to 4.1.3

+-+-+-+ +-+-+
|H|o|w| |t|o|
+-+-+-+ +-+-+

1) Switch to root user account on Linux server (hosted on Azure), where you want to upgrade the LIS drivers to 4.1.3

2) wget https://github.com/linuxelf001/LIS-4.1.3/blob/master/upgrade.sh; chmod u+x upgrade.sh; ./upgrade.sh

3) Reboot the server
