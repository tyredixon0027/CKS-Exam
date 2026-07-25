#!/bin/bash
# Question 10 — gVisor / RuntimeClass
# Node: node02 (via ssh from controlplane)
# Requires: q10_runtimeclass.yaml, q10_gvisor-pod.yaml in same directory
set -e

mkdir -p /opt/course/18

kubectl apply -f q10_runtimeclass.yaml
kubectl apply -f q10_gvisor-pod.yaml

echo ">>> Wait for pod to be running:"
kubectl get pod gvisor-test -n team-purple -w &
WATCH_PID=$!
sleep 10
kill $WATCH_PID 2>/dev/null || true

# Get dmesg from inside pod
kubectl exec -n team-purple gvisor-test -- dmesg > /opt/course/18/gvisor-test-dmesg

# Verify (gVisor dmesg will show "gVisor" references)
cat /opt/course/18/gvisor-test-dmesg
