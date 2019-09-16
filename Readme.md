## Elastic 7.x Mongo Python connector Example

This repo serves as an example of [ES7 doc manager for mongo-connector](https://github.com/tmpaul06/elastic7-doc-manager)

Elasticsearch is deprecating the usage of types, so this repo is an extension of [elastic2-doc-manager](https://github.com/yougov/elastic2-doc-manager) 
to support 7.x

## Running instructions
1. Make sure docker and docker-compose are installed on your system.
2. If you are running linux machine, you may need `sudo` before each command below.

3. Run `docker-compose up`, this will spawn up a MongDB primary, a MongoDB secondary, and Mongo Connector in a third docker container.
The python connector will wait for 20 seconds so that Mongo can elect a PRIMARY.

4. I've disabled the logs for mongo containers to prevent chattiness. You can remove the logging: driver: None from docker-compose file
to see Mongo logs


## Checking replication

1. Run `docker ps` to see a list of running containers
```
8564fbfef3dd        es7-mongo-example_mongo-connector                     "bash /tmp/connector…"   1 second ago        Up Less than a second                                      es7-mongo-example_mongo-connector_1
e820a58a273a        mongo:4.0                                             "docker-entrypoint.s…"   3 seconds ago       Up 2 seconds            27017/tcp                          es7-mongo-example_mongo-secondary_1
d21694fae2c0        docker.elastic.co/elasticsearch/elasticsearch:7.3.1   "/usr/local/bin/dock…"   3 seconds ago       Up 2 seconds            9300/tcp, 0.0.0.0:9208->9200/tcp   es7-mongo-example_es_1
d0eddb71300a        mongo:4.0                                             "docker-entrypoint.s…"   3 seconds ago       Up 2 seconds            27017/tcp                          es7-mongo-example_mongo-primary_1
```
2. Find out the container id of the Mongo primary container. In this case, it is `d0eddb71300a` [See the primary tag in name]
3. Run `docker exec -it d0eddb71300a mongo` to open mongo shell in container.
4. Create a sample db.
```mongodb
use foobar
```
5. Create a document
```mongodb
db.tanks.insert({'oh': 'yeah'})
```

6. Verify that document is present in ES by going to http://localhost:9208/foobar_tanks/_search
7. Update document and verify.
8. Once you are done with the testing parts, drop collection
```mongodb
db.tanks.drop()
```
This should remove the index from ES
