# IOT-Adapter
Connecting MQTT services with the i-Maintenance Messaging System.


This component subscribes to topics from the Internet of Things Protokoll MQTT and
forwards them to the the Apache Kafka message broker, based on semantic interpretation
from a SensorThings Server.


The Kafka Adapter based on the components:
* Paho-MQTT Messaging Client, [paho.mqtt](https://pypi.python.org/pypi/paho-mqtt/1.3.1) version **1.3.1**
* Kafka Client [librdkafka](https://github.com/geeknam/docker-confluent-python) version **0.11.1**
* Python Kafka module [confluent-kafka-python](https://github.com/confluentinc/confluent-kafka-python) version **0.9.1.2**


## Contents

1. [Requirements](#requirements)
2. [Deployment](#deployment)
3. [Configuration](#configuration)
4. [Trouble-Shooting](#trouble-shooting)


## Requirements

1. Install [Docker](https://www.docker.com/community-edition#/download) version **1.10.0+**
2. Install [Docker Compose](https://docs.docker.com/compose/install/) version **1.6.0+**
3. Clone this repository


## Deployment

The IOT-Adapter uses optionally Sensorthings to semantically describe
the forwarded data. The later consumage of the sensor data with the
suggested [DB-Adapter](https://github.com/i-maintenance/DB-Adapter/)
works best with a running and feeded 
[SensorThings](https://github.com/i-maintenance/SensorThingsClient) Client.



### Testing
Using `docker-compose`:

```bash
cd /iot-adapter
docker-compose up --build -d
```Trouble-shooting

The flag `-d` stands for running it in background (detached mode):


Watch the logs with:

```bash
docker-compose logs -f
```


### Deployment in a docker swarm
Using `docker stack`:

If not already done, add a regitry instance to register the image
```bash
cd /iot-Adapter
docker service create --name registry --publish published=5001,target=5000 registry:2
curl 127.0.0.1:5001/v2/
```
This should output `{}`:


If running with docker-coTrouble-shootingmpose works, push the image in
order to make the customized image runnable in the stack and deploy it:

```bash
cd ../iot-Adapter
./start-adapter.sh
```


Watch if everything worked fine with:

```bash
./show-adapter.sh
```


## Configuration

Most configurations are done in the `.env` file in which all environment
variables are set.

For more advanced options, the IOT-Adapter uses a Whitelist
(`datastreams.json`) as well as a
Blacklist (`blacklist.json`). The first one lists any data which should be
forwarded into the i-Maintenance Messaging System with its corresponding
SensorThings - Datastream-Id. The later lists sensordata that should be
ignored by the IOT-Adapter. If data is fetched without being in any of
these files, a warning message is produced that will be seen if running:

```bash
sudo docker service logs iot-adapter_adapter -f
```


## Trouble-shooting

#### Can't apt-get update in Dockerfile:
Restart the service

```sudo service docker restart```

or add the file `/etc/docker/daemon.json` with the content:
```
{
    "dns": [your_dns, "8.8.8.8"]
}
```
where `your_dns` can be found with the command:

```bash
nmcli device show <interfacename> | grep IP4.DNS
```

####  Traceback of non zero code 4 or 128:

Restart service with
```sudo service docker restart```

or add your dns address as described above




