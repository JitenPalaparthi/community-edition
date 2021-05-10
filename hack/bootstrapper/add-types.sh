#!/bin/bash

# needed for cert-manager
kubectl --kubeconfig=.kcp/data/admin.kubeconfig create ns default
kubectl --kubeconfig=.kcp/data/admin.kubeconfig create ns cert-manager-webhook
kubectl --kubeconfig=.kcp/data/admin.kubeconfig create ns capi-webhook-system

kubectl --kubeconfig=.kcp/data/admin.kubeconfig apply -f manifests/crds/core
kubectl --kubeconfig=.kcp/data/admin.kubeconfig apply -f manifests/crds/admissionregistration
sleep 5
kubectl --kubeconfig=.kcp/data/admin.kubeconfig apply -f manifests/cert-mgr
sleep 2
kubectl --kubeconfig=.kcp/data/admin.kubeconfig apply -f manifests/capi
