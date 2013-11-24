userList.sh is a Bash script to download a XML file that lists the user names from the Malayalam Wikipedia with at least one edit. With appropriate change in the URL, it can be used for other languages Wiki's where the API is supported.
createList.sh is a Bash script that generates a CSV file from the XML downloaded by the userList.sh script.

userList.sh
===========
userList.sh needs wget and uses the MediaWiki's Allusers API. It also uses xmlstarlet to extract data from XML files. The results are downloaded as XML files. The API parameter "aufrom" is used to fetch data beyond 500 and this will cause the id's passed to the aufrom to appear in multiple XML files. This script does not accept any parameters and it will generate a set of XML files with the names nnn.xml.

createList.sh
=============
createList.sh will generate a CSV file containing the uid and user names from the XML files downloaded by the userList.sh. This script needs xmlstarlet to extract data from XML files. This script two parameters : 1. The directory name in which the XML files downloaded by userList.sh and the name of the output CSV file.  
