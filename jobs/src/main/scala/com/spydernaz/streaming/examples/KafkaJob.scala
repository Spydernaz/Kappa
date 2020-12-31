package com.spydernaz.streaming.examples

import org.apache.flink.streaming.api.scala._
import org.apache.flink.api.common.typeinfo.TypeInformation
import org.apache.flink.streaming.api.windowing.time.Time
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaProducer
import org.apache.flink.api.common.serialization.SimpleStringSchema
import java.util.concurrent.TimeUnit
import java.util.Properties

object KafkaJob {
    
    def main(args: Array[String]) {
        // implicit val typeInfo = TypeInformation.of(classOf[(String)])
        
        val window = Time.of(10, TimeUnit.SECONDS)

        val properties = new Properties()
        properties.setProperty("bootstrap.servers", "kafka:9092")
        properties.setProperty("zookeeper.connect", "zookeeper:2181")
        properties.setProperty("group.id", "test")
        // val stream = env
        //     .addSource(new FlinkKafkaConsumer[String]("flink_test_in", new SimpleStringSchema(), properties))
        //     .print

        val env = StreamExecutionEnvironment.getExecutionEnvironment

        val myConsumer = new FlinkKafkaConsumer[String]("flink_test_in", new SimpleStringSchema(), properties)
        myConsumer.setStartFromEarliest()      // start from the earliest record possible
        // myConsumer.setStartFromLatest()        // start from the latest record
        // myConsumer.setStartFromTimestamp(...)  // start from specified epoch timestamp (milliseconds)
        // myConsumer.setStartFromGroupOffsets()  // the default behaviour
        val stream = env.addSource(myConsumer)


        val myProducer = new FlinkKafkaProducer[String]("flink_test_out", new SimpleStringSchema(), properties)
        stream.addSink(myProducer)

        env.execute("Flink Kafka Example")

    }
}
