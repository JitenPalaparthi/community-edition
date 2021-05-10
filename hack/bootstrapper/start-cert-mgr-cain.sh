#!/bin/bash

./bin/cert-manager-cainjector \
  --kubeconfig=./.kcp/data/admin.kubeconfig \
  --v=2 \
  --leader-election-namespace=kube-system
