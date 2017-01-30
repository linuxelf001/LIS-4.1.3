#!/bin/bash

LIS_TEMP='/tmp'
REQUIRED_MB=250
REQUIRED_ROOT_MB=100
URL='https://download.microsoft.com/download/7/6/B/76BE7A6E-E39F-436C-9353-F4B44EF966E9/lis-rpms-4.1.3.tar.gz'

#function that checks for free space at a path
space_check() {
	WHERE="$1"
	REQ="$2"
	#check for required free space
	DF="`df -B 1M "$WHERE" | tail -n +2 | head -n 1 | sed -e 's/ \+/ /g'`"
	MEGS=`echo "$DF" | cut -d\  -f4`

	#make sure it's a number and we don't have some error in the above command
	if ! [ "$MEGS" -eq "$MEGS" ]; then
		echo "Error in df command processing. Output line was:"
		echo "$DF"
		return 1
	fi

	if [ $MEGS -lt $REQ ]; then
		echo "$WHERE has only $MEGS MB free. I need at least $REQ MB."
		return 1
	fi
	return 0
}

#if LIS_TEMP is empty, df won't do what we want - at least set it to / if you want the root
if [ -z "$LIS_TEMP" ]; then
	echo "You must set the LIS_TEMP variable at the start of this script!"
	exit 1
fi

#bomb out if not root
if [ $EUID -ne 0 ]; then
	echo "This script must be run as root!"
	exit 1
fi

#make sure base temp dir exists
if [ ! -d "$LIS_TEMP" ]; then
	echo "$LIS_TEMP doesn't exist or isn't a directory"
	exit 1
fi

#check for free space
MOUNTPOINT="`df "$LIS_TEMP" | tail -n +2 | head -n 1 | sed -e 's/ \+/ /g' | cut -d\  -f6`"
if [ "$MOUNTPOINT" == "/" ]; then
	#if tmp is in /, combine the required space amounts
	space_check "/" $((REQUIRED_MB + REQUIRED_ROOT_MB)) || exit 1
else
	#otherwise check both places
	space_check "$LIS_TEMP" "$REQUIRED_MB" || exit 1
	space_check "/" "$REQUIRED_ROOT_MB" || exit 1
fi

#make a temp dir so we can delete it later
TEMP="`mktemp -p "$LIS_TEMP" -d`"

#do the thing
cd "$TEMP" || exit 1
echo "Downloading $URL"
wget -O- "$URL" | tar xzvf - || exit 1
cd LISISO || exit 1
./upgrade.sh || exit 1

#clean up
#first get out of the temp dir we're going to delete
echo "SUCCESS! Cleaning up temporary files..."
cd "$TEMP/.." || exit 1
rm -rf "$TEMP"
echo "Temporary files have been deleted"
