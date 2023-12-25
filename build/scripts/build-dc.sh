#!/bin/bash

set -e

PWD=$(pwd)
constant=airflow
gitPath=${PWD}/build/scripts
AirflowVersion=2.7.1
Shortsha=$1
LineCount=$(cat $gitPath/repos-dc | wc -w)
dockerLocal=local:$Shortsha

echo "airflow:${AirflowVersion}-${Shortsha}" > deploy/images/airflow-image
docker build -t $dockerLocal $PWD/build


for (( i=1; i <=$LineCount; i++ ))
do
    REPONAME=$(sed -n "${i}p"  $gitPath/repos-dc | tr -d '\n')
    REGISTRY="${REPONAME}/${constant}:${AirflowVersion}-${Shortsha}"
    echo "$REGISTRY"
    docker tag $dockerLocal $REGISTRY
    docker push $REGISTRY
done

