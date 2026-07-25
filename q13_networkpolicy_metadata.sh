#!/bin/bash
# Question 13 — NetworkPolicy: Block Metadata Server
# Node: controlplane
# Requires: q13_metadata-deny.yaml, q13_metadata-allow.yaml in same directory
set -e

kubectl apply -f q13_metadata-deny.yaml
kubectl apply -f q13_metadata-allow.yaml

echo ">>> Test: non-accessor pod should be blocked"
echo "kubectl exec -n metadata-access <regular-pod> -- curl 192.168.100.21:32000"

echo ">>> Test: accessor pod should work"
echo "kubectl exec -n metadata-access <accessor-pod> -- curl 192.168.100.21:32000"
