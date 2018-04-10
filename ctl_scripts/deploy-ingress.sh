#!/bin/bash

CREDENTIALS_DIR="$HOME/.genny/credentials"
CREDENTIALS="credentials"
CREDENTIALS_PROJECT="$CREDENTIALS_DIR/$CREDENTIALS"
ENV_FILE=genny.env
$repo_url
$project
$ip
$project_realm

if [ ! -d "$CREDENTIALS_DIR" ]; then
   mkdir -p $CREDENTIALS_DIR
else
   echo "$CREDENTIALS_DIR alreasy exists"
fi

kubectl create secret tls tls-certificate --key $HOME/certs/outcome-hub.com.key --cert $HOME/certs/outcome-hub.com.pem
kubectl create --namespace=kube-system secret generic tls-dhparam --from-file=/home/ubuntu/kate-staging/kate-data/certs/dh-para


kubectl create -f ../kate/ingress/roles-to-default.yaml

kubectl create -f ../kate/ingress/default-backend.yaml
kubectl create -f ../kate/ingress/nginx-controller.yaml
kubectl create -f ../kate/ingress/ingress.yaml
