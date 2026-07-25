#!/bin/bash
# Question 3 — APIServer Service Type Change
# Node: controlplane
set -e

# Check current service
kubectl get svc -n default kubernetes
kubectl get svc -A | grep apiserver

echo ">>> Now run: kubectl edit svc kubernetes"
echo ">>> Change:  type: NodePort  ->  type: ClusterIP"
echo ">>> Remove any nodePort fields from ports spec"

# Verify after editing
kubectl get svc kubernetes
