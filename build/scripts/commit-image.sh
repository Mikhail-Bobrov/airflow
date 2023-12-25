#!/bin/bash

set -e

GIT_URL=git@git.ridotto.by:infra/airflow-k8s.git
SHORTSHA=$1
AirflowVersion=2.7.1

git clone $GIT_URL -b master
cd airflow-k8s
git status
echo "airflow:${AirflowVersion}-${SHORTSHA}" > deploy/images/airflow-image
cat deploy/images/airflow-image
git status
git add deploy/images/airflow-image
git commit -m "Auto-commit image version for airflow"
git push origin master
