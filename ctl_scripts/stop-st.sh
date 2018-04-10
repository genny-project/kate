#!/bin/bash



kubectl delete -f ../manifest/ -R --namespace=staging

#kubectl delete configmap entrypoint 
#kubectl delete configmap genny-env --namespace=staging
#kubectl delete secret tls-certificate 
#kubectl delete secret tls-dhparam 
 
kubectl delete ns staging 
