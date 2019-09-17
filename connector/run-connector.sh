sleep 20
mongo-connector -m "mongo-standalone:27017" -t "es:9200" -d "elastic7_doc_manager" --stdout
