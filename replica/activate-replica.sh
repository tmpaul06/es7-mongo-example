#Wait for primary
until mongo --host mongo-standalone --eval "print(\"waited for connection\")"
do
    sleep 1
done

#you can add more MongoDB waits here

echo "Adding replica config"
mongo --host mongo-standalone --eval "rs.initiate()"
echo "Replica set initiated"
