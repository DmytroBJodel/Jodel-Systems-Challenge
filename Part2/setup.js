replConfig = { "_id" : "mongo-replSet-01", "members" : [ { "_id" : 0, "host" : "test2_mongonode01_1:27017" }, { "_id" : 1, "host" : "test2_mongonode02_1:27017" }, { "_id" : 2, "host" : "test2_mongonode03_1:27017" } ] }
rs.initiate(replConfig)
rs.slaveOk()
