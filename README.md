# Project Kappa #

---

## About Kappa ##

Firstly, this is a Cyber Analytics Platform (CAP) - so naturally we use the greek letter Kappa (K) :)

This project is targeting the build, analytics and reponses to cyber threats. There are a lot of particular usecases that we hope to flesh out and build some Proof of Concepts around; in particular ML detection in real time (using [Apache Flink](https://flink.apache.org/) as the Streaming Engine), sharing of threat intelligce across "organisations" for the improvement of detection / models (especially sharing attack behaviours) and hopefully automated responses / playbooks.

### Running Kappa ###

At the moment, Kappa is only Apache Flink, Zookeeper and Kafka. There is a sample job included in the delpoyment that just copies messages from one topic to another. As we progress this project, we hope to include many more samples and the ability to generate / use sample data to show how we are meeting a bunch of the usecases we want to solve for.

Get the repo:

```sh
# This requires git, and an internet connection
cd ~
git clone https://github.com/Spydernaz/Kappa.git
cd Kappa
```

To start and run Kappa:

```sh
# This requires docker, docker-compose, maven, and internet connection (not sure if Scala is actually required to be installed on your system. If someone has an issue, please share and I can help look into it)
./kappa.sh start
```

To stop you can run:

```sh
./kappa.sh stop
```

### Challenges ###

Data Issues:

1. Often breaches aren't detected till long after they occur so it is hard to find data that accurately represents the enviroment at the time.
2. Following on from the above is log retention. As high verbose security logs produce a lot of information, it presents a challenge to the cost / benefit of long term storage of this information.
3. Organisations in general dont like to share (potentially sensitive) security logs making it extremely hard for open source to help contribute to modelling / testing.

Organisational Issues:

1. People are the biggest asset but also the biggest liability. Most employees can undo lots of work by falling subject to simple attacks that target them (i.e. Phishing)

## Why? ##

I have been annoyed and it was time to do something about it. I too often see companies spending lots of money to not be the weakest or lowest hanging fruit for an attacker. It reminds me of the below:

> If you are being chased by a lion you dont have to be the fastest, just dont be the slowest
> ~ Can't Remember

The issue to me here is that this has led to a lack of sharing and helping other companies who potentially cant spend as much. Instead of just protecting a brand, I prefer to think that we should be doing what we can to protect the individual regardless of which company they use.
On the flip side, the dark web is full of exploits and information that is shared either freely, or at least affordably that has the potential to break the large amounts of investment by blue teams. This just re-enforces my point of view that we need to band closer together, share information and try to detect attack behaviours as close to real time as possible.

Please reach out if this is something of interest to you and want to give some time / skill / experience or advice.
