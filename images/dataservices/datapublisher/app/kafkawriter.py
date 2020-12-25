from confluent_kafka import Consumer, Producer, KafkaError, KafkaException, TopicPartition, OFFSET_END
import json, socket


class kafkaWriter(object):
    def __init__(self,bootstrap_server="kafka:9092"):
        self._bootstrap_server = bootstrap_server
        print(f"Bootstrap.servers = {self._bootstrap_server}")

    def connect(self, topic):
        self._topic = topic
        self._producer = Producer({
            "bootstrap.servers": self._bootstrap_server
        })
    
    def send_message(self, key=None, message=None):
        print(f"self._producer.produce(topic='{self._topic}', value='{message}')")
        self._producer.produce(topic=self._topic, value=message)