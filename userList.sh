#! /usr/bin/bash

# Script to download the list of wiki users having at least one edit using
# Allusers API
# Prime Jyothi (primejyothi@gmail.com), 20131110
# License GPLv3

api="http://ml.wikipedia.org/w/api.php?action=query&list=allusers&auexcludegroup=bot&auprop=editcount|groups&auwitheditsonly&aulimit=500&format=xml"
auexcludegroup=bot&auprop=editcount


stopSign="ALongStringThatIndicateItIsTimeToStop"
count=1
max=100

function log ()
{
	echo "Log: $@"
}

function lastUname ()
{
	# Extract the last username from the given XML file
	u=`xmlstarlet sel -T  -t -m /api/query/allusers/u -v "@name" -n  $1  |
		tail -1`
	if [[ -z "$u" ]]
	then
		# No data found.
		u=$stopSign
	fi
	elCount=`xmlstarlet sel -T  -t -m /api/query/allusers/u -v "@name" -n $1 |
		wc -l`
	if [[ $elCount -eq 1 ]]
	then
		# There is only one record, end of data
		# Since the aufrom parameter is used, the returned data will contain
		# one record. Will take this as end of data
		u=$stopSign
	fi
	echo $u
}

# First set of data
wget $api -O 1.xml 2> /dev/null
while :
do
	if [[ $count -gt $max ]]
	then
		break
	fi
	last=`lastUname ${count}.xml`
	if [[ "$last" = $stopSign ]]
	then
		# End of data or some error, stop the process
		log "End of data"
		break
	fi
	log count = $count, last $last

	startUser="&aufrom=$last"
	log startUser $startUser

	count=`expr $count + 1`

	url=${api}${startUser}
	log url $url

	wget "$url" -O ${count}.xml 2> /dev/null
	# Be nice, give the server a break before next request
	sleep 2
done
