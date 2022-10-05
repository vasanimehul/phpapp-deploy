#!/bin/sh
AWS_ECS_CONTAINER_INSTANCE_ARN=$(aws ecs list-container-instances --cluster spoonbill-dev --query 'containerInstanceArns' --output text)&& 
aws ecs deregister-container-instance --cluster spoonbill-dev --container-instance $AWS_ECS_CONTAINER_INSTANCE_ARN --force
