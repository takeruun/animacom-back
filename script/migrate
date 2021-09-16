#!/bin/bash

output=`aws ecs describe-services --cluster animacom-cluster --services animacom-service | jq ".services[0].networkConfiguration"`

subnets=`echo $output | jq -r '.awsvpcConfiguration.subnets|join(",")'`
echo $subnets
securityGroups=`echo $output | jq -r '.awsvpcConfiguration.securityGroups|join(",")'`
echo $securityGroups
assignPublicIp=`echo $output | jq -r '.awsvpcConfiguration.assignPublicIp'`

aws ecs run-task \
  --cluster animacom-cluster \
  --task-definition animacom-task \
  --launch-type FARGATE \
  --overrides file://run_task_db_migrate.json \
  --network-configuration "awsvpcConfiguration={subnets=[${subnets}],securityGroups=[${securityGroups}],assignPublicIp=${assignPublicIp}}"