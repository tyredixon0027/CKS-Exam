#!/bin/bash
# Question 4 — Pod Security Standards (Baseline)
# Node: controlplane
# NOTE: replace <container-host-hacker-pod> and <replicaset-name> with real values
set -e

mkdir -p /opt/course/4

# Label namespace to enforce baseline PSS
kubectl label namespace team-red \
  pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/enforce-version=latest

# Verify label
kubectl get ns team-red --show-labels

# Delete the offending pod (ReplicaSet will try and fail to recreate it)
kubectl get pods -n team-red
echo ">>> Set <container-host-hacker-pod> to the pod name, then run:"
echo "kubectl delete pod <container-host-hacker-pod> -n team-red"

# Check ReplicaSet events for the reason
kubectl get rs -n team-red
echo ">>> Set <replicaset-name> to the RS name, then run:"
echo "kubectl describe rs <replicaset-name> -n team-red | grep -A5 'Warning'"

# Write event lines to file
echo "kubectl describe rs <replicaset-name> -n team-red | grep -i 'forbidden\\|Error\\|Warning' > /opt/course/4/logs"

# Verify
echo "cat /opt/course/4/logs"
