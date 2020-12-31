source .env

# Print out the purpose of the script
echo "\n\nProject Kappa\n---------\nThis project is intended to demo an environment for Kappa, a Cyber Analytics Platform (CAP).\n\n"

function printhelp_fn {
    echo "This script functions as the controller for the demo."
    echo "The available routines are 'start', 'stop' and 'help'"
}

function checkrequirements_fn {
    failed=0
    echo "Using `docker-compose -v`" || failed=1

    if [ $failed == 1 ]; then
        exit 128
    fi
}


function startkappa_fn {
    echo "Starting Kappa! \n\n"
    # checkrequirements_fn
    # Start core services
    docker-compose -p kappa -f ./images/docker-compose.yaml up -d zookeeper kafka jobmanager taskmanager
    docker-compose -p kappa -f ./images/docker-compose.yaml scale taskmanager=3

    echo "Sleeping for 30 seconds to wait for services to start"
    sleep 30
    docker exec -it kappa_kafka_1 kafka-topics --bootstrap-server kafka:9092 --create --topic flink_test_in -partitions 1 --replication-factor 1
    docker exec -it kappa_kafka_1 kafka-topics --bootstrap-server kafka:9092 --create --topic flink_test_out -partitions 1 --replication-factor 1
    
    sleep 2
    echo "Topics created:"
    docker exec -it kappa_kafka_1 kafka-topics --list --zookeeper zookeeper:2181

    echo "Compiling and uploading example kafka job."
    cd jobs
    mvn clean package
    jarid=`curl -X POST -H "Expect:" -F "jarfile=@target/com.spydernaz.streaming.examples-1.1-SNAPSHOT-jar-with-dependencies.jar" http://localhost:8081/jars/upload | cut -f 5 -d '/' | cut -f 1 -d ',' | sed 's/"//'`

    echo -e "submitting job: ${jarid}"
    curl -X POST "http://localhost:8081/jars/${jarid}/run?entry-class=com.spydernaz.streaming.examples.KafkaJob"
}

function gendata_fn {
    echo "not implemented"
    # docker exec -it kappa_kafka_1 kafka-console-producer --bootstrap-server localhost:9092 --topic flink_test_in
    exit 128
}
function readdata_fn {
    echo "not implemented"
    # docker exec -it kappa_kafka_1 kafka-console-consumer --from-beginning --bootstrap-server kafka:9092 --topic flink_test_in
    exit 128
}

function stopkappa_fn {
    echo "Stopping Kappa! \n\n"
    docker-compose -p kappa -f ./images/docker-compose.yaml down --remove-orphans
}


if [ $1 == "start" ]; then 
    startkappa_fn
elif [ $1 == "stop" ]; then
    stopkappa_fn
elif [ $1 == "help" ]; then
    printhelp_fn
else
    printhelp_fn
fi