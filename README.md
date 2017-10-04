This is readme for Jodel challendge project by Dmytro Boiko

Test machine:
cat /etc/redhat-release 
CentOS Linux release 7.4.1708 (Core) 

uname -rms
Linux 3.10.0-693.2.2.el7.x86_64 x86_64

docker --version
Docker version 17.09.0-ce, build afdb6d4

docker version
Client:
 Version:      17.09.0-ce
 API version:  1.32
 Go version:   go1.8.3
 Git commit:   afdb6d4
 Built:        Tue Sep 26 22:41:23 2017
 OS/Arch:      linux/amd64

Server:
 Version:      17.09.0-ce
 API version:  1.32 (minimum version 1.12)
 Go version:   go1.8.3
 Git commit:   afdb6d4
 Built:        Tue Sep 26 22:42:49 2017
 OS/Arch:      linux/amd64
 Experimental: false

docker-compose version
docker-compose version 1.11.1, build 7c5d5e4
docker-py version: 2.0.2
CPython version: 2.7.13
OpenSSL version: OpenSSL 1.0.1t  3 May 2016


Part 1:
Create a Docker Container with a /status HTTP endpoint on port 8080, which should return container's system info'

Dockerfile contains just couple instructions:
Pull image, expose port and copy httpd config + status script.
the only change in default httpd conf is string 
ScriptAlias /status "/usr/local/apache2/cgi-bin/sysinfo.sh"
Status script is quite simple bash script to gather systems stats and formatting 

Run string: 
docker build -t jsep1 . && docker run -d -p 8080:80 jsep1 && elinks http://localhost:8080/status




Part 2:
Create a MongoDB infrastructure using docker compose 
Dockerfile: pulls image, expose port, set mongo parameters run mongo with replica set create new volume
docker-compose.yml: run 3 services 
mongod.conf: replicaset paramater
setup.js: instructions for mongo to run replica

Run string:
docker-compose up -d --build

Docker compose will start 3 containers with running mongo in each. In this case we can spawn any amount of mongo containers by running
'docker-compose scale mongonodeX=4'. Also in this case we do not use static IPs or hostnames.
Unfortunatelly I was not able to make automagically a replicaset - 
either instruction mongo < replica.js fails with "can not connect to 127.0.0.1:27017" or replica fails to be created with mongo error 
"can not create replica, database already has data".

Also using same(or even more simple) Dockerfile it is possible to create replicaset manually by running:
docker network create mongo-cluster01
docker run -d -p 30001:27017 --name mongonode01 --net mongo-cluster01 mongo mongod --replSet mongo-replSet-01
docker run -d -p 30002:27017 --name mongonode02 --net mongo-cluster01 mongo mongod --replSet mongo-replSet-01
docker run -d -p 30003:27017 --name mongonode03 --net mongo-cluster01 mongo mongod --replSet mongo-replSet-01
db = (new Mongo('localhost:27017')).getDB('names')
config = { "_id" : "mongo-replSet-01", "members" : [ { "_id" : 0, "host" : "mongonode01:27017" }, { "_id" : 1, "host" : "mongonode02:27017" }, { "_id" : 2, "host" : "mongonode03:27017" } ] }

rs.initiate(config)
db.testcollection.insert({name : 'User1'})
db.testcollection.insert({name : 'User2'})
db.testcollection.find()

@On another node:
SECONDARY: db2 = (new Mongo(':27017')).getDB('names')
SECONDARY: db2.setSlaveOk()
SECONDARY: db2.testcollection.find()
db.runCommand( { replSetGetStatus : 1 } )
