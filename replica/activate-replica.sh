#Wait for primary
until mongo --host mongo-primary --eval "print(\"waited for connection\")"
do
    sleep 1
done

#Wait for mongo secondary
until mongo --host mongo-secondary --eval "print(\"waited for connection\")"
do
    sleep 1
done

#you can add more MongoDB waits here

echo "Adding replica config"
mongo --host mongo-primary --eval "rs.initiate({\"_id\": \"myDevReplSet\", \"members\": [{\"_id\": 1, \"host\": \"mongo-primary\"}, {\"_id\": 2, \"host\": \"mongo-secondary\", \"priority\": 0.5}]})"
echo "Replica set initiated"
