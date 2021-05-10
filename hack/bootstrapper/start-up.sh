#!/bin/bash

echo "== starting kcp =="
./bin/kcp start &> kcp.log &

sleep 20

echo "== starting cert-manager =="
./bin/cert-manager --kubeconfig=bin/.kcp/data/admin.kubeconfig &> cert-mgr.log &
