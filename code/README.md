# Exporter for MongoDB to s3 Bucket

Can run this docker to conenct to a MongoDB and performe a backup.
The outputtet data is then uploaded to a s3 bucket.


## MONGODUMP
Mongo dump will dump the collection given and performe a regular dump.


## MONGOEXPORT
Will run the QUERY env aginst the MongoDB to extract data. The data is exported in JSON format adn then uploaded to s3 bucket




### Local dev
To test run the full docker-comopse to start a Mongodb and a mongo-express. Then load the data into you MongoDB to test



## ENV 


### ACTION: MONGODUMP
Action to do can be MONGODUMP ore MONGOEXPORT


### MONGO_HOST: mongo
Host name of mongo

### MONGO_USER: root
MongoDB user to use

### MONGO_PASS: example
MongoDB Password to use

### MONGO_DB: test
MongoDB database to use

### MONGO_COL: id
MongoDB Collections to use


### MONGO_QUERY: '{"city":"HAMPDEN"}'
MongoDB Query to run. This is only use then set ACTION to MONGOEXPORT

### AWS_ACCESS_KEY_ID:
Your AWS ACCESS KEY ID  

### AWS_SECRET_ACCESS_KEY: NSPd
Your AWS ACCESS KEY

### AWS_BUCKET: mongo-backup
The bucket to use



## Test data
If you want to test you can upload the test data into mongo my docker exec into the MongoDB container and run 


```
command: mongoimport -v --file=zips.json -u=root -p=example  --db test --collection id --authenticationDatabase admin
```


