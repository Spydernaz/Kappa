# List all topics
kafka-topics --list --zookeeper zookeeper:2181

# Create the Lanl topic
kafka-topics --bootstrap-server kafka:9092 --create --topic lanl_netflow_data -partitions 1 --replication-factor 1
kafka-topics --bootstrap-server kafka:9092 --create --topic flink_test -partitions 1 --replication-factor 1

# Listen to all messages 
#kafka-console-consumer --from-beginning --bootstrap-server kafka:9092 --topic lanl_netflow_data