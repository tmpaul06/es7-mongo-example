## Elastic 7.x Mongo Python connector Example

This repo serves as an example of [ES7 doc manager for mongo-connector](https://github.com/tmpaul06/elastic7-doc-manager)

Elasticsearch is deprecating the usage of types, so this repo is an extension of [elastic2-doc-manager](https://github.com/yougov/elastic2-doc-manager) 
to support 7.x

## Running instructions
1. Make sure docker and docker-compose are installed on your system.
2. If you are running linux machine, you may need `sudo` before each command below.

3. Run `docker-compose up`, this will spawn up a MongDB standalone and Mongo Connector in a third docker container.
The python connector will wait for 20 seconds so that Mongo standalone can initiate a replica set.

	> Do not worry if you see the container replica-activator exit, this to work-around some issues with running mongo in docker. https://github.com/yougov/mongo-connector/issues/391

4. I've disabled the logs for mongo containers to prevent chattiness. You can remove the logging: driver: None from docker-compose file
to see Mongo logs


## Checking replication

1. Run `docker ps` to see a list of running containers
```
c4df563e90b9        es7-mongo-example_mongo-connector                     "bash /tmp/connector…"   18 seconds ago      Up 17 seconds                                          es7-mongo-example_mongo-connector_1
0a7aa6671a7d        mongo:4.0                                             "docker-entrypoint.s…"   21 seconds ago      Up 19 seconds       27017/tcp                          es7-mongo-example_mongo-standalone_1
ce197084e88c        docker.elastic.co/elasticsearch/elasticsearch:7.3.1   "/usr/local/bin/dock…"   2 minutes ago       Up 19 seconds       9300/tcp, 0.0.0.0:9208->9200/tcp   es7-mongo-example_es_1
```
2. Find out the container id of the Mongo standalone container. In this case, it is `0a7aa6671a7d` [See the standalone tag in name]
3. Run `docker exec -it 0a7aa6671a7d mongo` to open mongo shell in container.
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
