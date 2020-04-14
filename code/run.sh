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
mkdir /opt/backup/mongo_out

if [ $MONGO_USER = "NONE" ]
then
mongodump --db=$MONGO_DB --collection=$MONGO_COL --gzip --archive=/opt/backup/mongo_out/$d/$MONGO_COL.gz

else
mongodump --host="$MONGO_HOST:27017"  -u=$MONGO_USER -p=$MONGO_PASS  --db=$MONGO_DB --collection=$MONGO_COL --authenticationDatabase admin --gzip --archive=/opt/backup/mongo_out/$d/$MONGO_COL.gz 
echo "Your data have bean saved to /mongo_out folder"
fi
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
mkdir /opt/backup/mongo_out
if [ $MONGO_USER = "NONE" ]
then

mongoexport  --db=$MONGO_DB --collection=$MONGO_COL --out=/opt/backup/mongo_out/$d/$MONGO_DB_$MONGO_COL_export.json --query="$MONGO_QUERY"

else
mongoexport --host="$MONGO_HOST:27017"  -u=$MONGO_USER -p=$MONGO_PASS  --db=$MONGO_DB --collection=$MONGO_COL --authenticationDatabase admin --out=/opt/backup/mongo_out/$d/$MONGO_DB_$MONGO_COL_export.json --query "$MONGO_QUERY"
echo "Your data have bean saved to /mongo_out folder"
fi
fi

############################
#
# This will upload the folder /mongo_out to s3 bucket

aws s3 sync /opt/backup/mongo_out/$d/ s3://$AWS_BUCKET/$d/
