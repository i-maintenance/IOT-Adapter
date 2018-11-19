#!/usr/bin/env bash
echo "Printing 'docker service ls | grep iot-adapter':"
docker service ls | grep iot-adapter
echo ""
echo "Printing 'docker stack ps iot-adapter':"
docker stack ps iot-adapter
