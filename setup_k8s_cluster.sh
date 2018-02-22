#!/usr/bin/env bash

## Taken from http://zero-to-jupyterhub.readthedocs.io

kubectl --namespace kube-system create sa tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
kubectl --namespace=kube-system patch deployment tiller-deploy --type=json --patch='[{"op": "add", "path": "/spec/template/spec/containers/0/command", "value": ["/tiller", "--listen=localhost:44134"]}]'
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
