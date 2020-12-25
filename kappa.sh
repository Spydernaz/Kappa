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