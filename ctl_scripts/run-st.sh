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

#kubectl create secret tls tls-certificate --key $HOME/certs/outcome-hub.com.key --cert $HOME/certs/outcome-hub.com.pem
#kubectl create staging secret generic tls-dhparam --from-file=/home/ubuntu/kate-staging/data/certs/dh-para

kubectl create ns staging


kubectl apply -f ../manifest/ -R --namespace=staging


kubectl create configmap entrypoint --from-file=../manifest/qwanda-service/overriden-entrypoint.sh --namespace=staging
kubectl create configmap realm --from-file=../data/realm/ --namespace=staging
kubectl create configmap rules --from-file=../data/rules/ --namespace=staging

#kubectl create configmap genny-env --from-env-file=../data/data/genny.env --namespace=staging
kubectl create configmap qwanda-svc-env --from-env-file=../data/data/qwanda-service.env --namespace=staging
kubectl create configmap rulesservice-env --from-env-file=../data/data/rulesservice.env --namespace=staging
kubectl create configmap alyson-env --from-env-file=../data/data/alyson.env --namespace=staging
kubectl create configmap payments-env --from-env-file=../data/data/payments.env --namespace=staging
kubectl create configmap social-env --from-env-file=../data/data/social.env --namespace=staging
kubectl create configmap uppy-env --from-env-file=../data/data/uppy.env --namespace=staging

kubectl create secret generic credential --from-file=$CREDENTIALS_PROJECT-interns/StoredCredential --namespace=staging

