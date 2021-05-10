#!/bin/bash

./bin/cert-manager-webhook \
  --kubeconfig=./.kcp/data/admin.kubeconfig \
  --v=10 \
  --secure-port=10250 \
  --dynamic-serving-ca-secret-namespace=cert-manager-webhook \
  --dynamic-serving-ca-secret-name=cert-manager-webhook-ca \
  --dynamic-serving-dns-names=127.0.0.1,localhost,cert-mmggr,cert-manager-webhook,cert-manager-webhook.cert-manager,cert-manager-webhook.cert-manager.svc
