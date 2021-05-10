#!/bin/bash

./bin/cert-manager \
  --kubeconfig=./.kcp/data/admin.kubeconfig \
  --v=2 \
  --cluster-resource-namespace=cert-manager \
  --leader-election-namespace=kube-system
