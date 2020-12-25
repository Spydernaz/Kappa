from confluent_kafka import Producer
import json, time


p = Producer({"bootstrap.servers": "kafka:9092"})
with open("/data/sample_lanlnetflow", "r") as f:
    for line in f:
        print(f"putting new record on `lanl_netflow_data`. record: {line}")
        p.produce(topic='lanl_netflow_data',value=line)