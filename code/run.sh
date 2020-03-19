#!/bin/bash


##########################
#
# Setup the AWS access 
#
/code/aws.sh






############################
#
# This will dump the full collection using mongodump
#
############################
if [ $ACTION = "MONGODUMP" ]
then

echo "Exporting mongodb collections"
mkdir /mongo_out
mongodump --host="$MONGO_HOST:27017"  -u=$MONGO_USER -p=$MONGO_PASS  --db=$MONGO_DB --collection=$MONGO_COL --authenticationDatabase admin --out=/mongo_out/ --forceTableScan
echo "Your data have bean saved to /mongo_out folder"
fi

d=`date +%m-%d-%Y`

############################
#
# This will run a query and export the result
#
############################
if [ $ACTION = "MONGOEXPORT" ]
then

echo "Exporting mongodb query"
mkdir /mongo_out
mongoexport --host="$MONGO_HOST:27017"  -u=$MONGO_USER -p=$MONGO_PASS  --db=$MONGO_DB --collection=$MONGO_COL --authenticationDatabase admin --out=/mongo_out/export.json --query $MONGO_QUERY
echo "Your data have bean saved to /mongo_out folder"
fi


############################
#
# This will upload the folder /mongo_out to s3 bucket

aws s3 sync /mongo_out/ s3://$AWS_BUCKET/$d/