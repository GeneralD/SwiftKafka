#!/bin/bash

set -o verbose

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    brew update
    brew cask install homebrew/cask-versions/adoptopenjdk8
    brew install kafka
    brew install librdkafka
    brew services start zookeeper
    brew services start kafka
    sleep 9
else
    apt-get update
    apt-get install -y wget
    wget -qO - https://packages.confluent.io/deb/5.2/archive.key | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/5.2 stable main" -y
    sudo apt-get update -q
    sudo apt-get install confluent-librdkafka-plugins -y
    sudo apt-get update && sudo apt-get install confluent-community-2.12
    apt install librdkafka-dev
    wget https://www-eu.apache.org/dist/kafka/2.2.0/kafka_2.12-2.2.0.tgz -O kafka.tgz
    mkdir -p kafka && tar xzf kafka.tgz -C kafka --strip-components 1
    nohup bash -c "cd kafka && bin/zookeeper-server-start.sh config/zookeeper.properties &"
    nohup bash -c "cd kafka && bin/kafka-server-start.sh config/server.properties &"
    sleep 5
    # apt-get update
    # apt-get install -y wget
    # apt-get install librdkafka-dev
    # wget https://www-eu.apache.org/dist/kafka/2.2.0/kafka_2.12-2.2.0.tgz -O -O kafka.tgz
    # mkdir -p kafka && tar xzf kafka.tgz -C kafka --strip-components 1
    # cd kafka
    # ./bin/zookeeper-server-start.sh config/zookeeper.properties &
    # sleep 3
    # ./bin/kafka-server-start.sh config/server.properties &
    # - sleep 5
fi
