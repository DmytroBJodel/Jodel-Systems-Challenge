FROM mongo:latest
EXPOSE 27017

# Modify child mongo to use /data/db2 as dbpath 
RUN mkdir -p /data/db2 \
    && echo "dbpath = /data/db2" > /etc/mongodb.conf \
	&& echo "replSet = mongo-replSet-01" >> /etc/mongodb.conf \
    && chown -R mongodb:mongodb /data/db2

COPY . /data/db2

RUN mongod --fork --logpath /var/log/mongodb.log --dbpath /data/db2 --smallfiles \
	&& sleep 15 \   							  # wait for mongod to start
    && mongo 127.0.0.1:27017 /data/db2/setup.js \ # set replica data 
    && mongod --dbpath /data/db2 --shutdown \  	  # set path
    && chown -R mongodb /data/db2				  # set permissions	
    && rm -r /tmp/mongodb-27017.sock

# Make the new dir a VOLUME to persists it 
VOLUME /data/db2

CMD ["mongod", "--config", "/etc/mongodb.conf", "--smallfiles", "--replSet", "mongo-replSet-01"]
