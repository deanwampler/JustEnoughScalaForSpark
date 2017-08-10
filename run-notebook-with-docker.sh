#!/bin/bash

this_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
docker=$(which docker 2>/dev/null) 
if [ -z "$docker" ]; then
	echo "It does not appear that docker is installed, or at least not in your path. Please fix and re-run this script..."
	exit 1
fi

echo "Showing docker client/server version..."
$docker version 
if [ $? -ne 0 ]; then
	echo "It appears that the docker server is not running, please restart docker and re-run this script..."
	exit 2
fi

$docker pull andypetrella/spark-notebook:0.7.0-scala-2.11.8-spark-2.1.0-hadoop-2.7.2-with-hive
exec $docker run -p 9001:9001 -v $this_dir/notebooks:/opt/docker/notebooks/lightbend andypetrella/spark-notebook:0.7.0-scala-2.11.8-spark-2.1.0-hadoop-2.7.2-with-hive
