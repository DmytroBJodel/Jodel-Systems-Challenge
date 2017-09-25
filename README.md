Welcome!

For this challenge we would like to see you create immutable docker set for 2 different tasks.


## Status Endpoint

Create a Docker Container with a `/status` HTTP endpoint on port 8080, which should return container's system info, including the following:

- Uptime;
- Free/used memory;
- Free/used disk space;
- Kernel version;
- Established network connections;
- Current running processes;
- All local hard drives disk utilization;

You can use any language you want for this task.


## MongoDB Installation with Replication

Create a MongoDB infrastructure using docker compose and everything you need for it.

`docker-compose up` should create and run at least 3 mongodb containers that will automagically form a replicaset.

You can't use static hostnames or ips for mongodb containers. All mongodb containers from a replicaset should discover each other and agree about who will be the master.

It should be possible to run any number of mongodb containers via docker compose and they should be still able to discover each other and form a replicaset.


## How to deliver your results

Fork this repo and once you're done send us a link to a repo with your solution. The result should be your own repository on Github with instructions how to run everything.

