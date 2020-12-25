from confluent_kafka import Producer
import json, time


p = Producer({"bootstrap.servers": "localhost:29092"})
with open("/Users/valana/Projects/personal/Kappa/images/dataservices/datapublisher/data/sample_lanlnetflow", "r") as f:
    for line in f:
        p.produce(topic='lanl_netflow_data',value=line)