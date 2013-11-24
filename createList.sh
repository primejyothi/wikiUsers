#! /usr/bin/bash

# Script generate a CSV file from the xml files generated using the
# Allusers API
# Prime Jyothi (primejyothi@gmail.com), 20131110
# License GPLv3

if [[ $# -ne 2 ]]
then
	echo "Usage : `basename $0` directoryWithXMLS outputFile"
	exit 1
fi

inDir=$1
outFile=$2

xmlstarlet sel -T  -t -m /api/query/allusers/u -v   "concat(@userid, ',', @name,',',@editcount)" -n ${inDir}/*.xml  | sort | uniq > $outFile
