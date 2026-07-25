#!/bin/bash
# Question 17 — Audit Logging Policy
# Node: controlplane
# Requires: q17_policy.yaml in same directory
set -e

sudo -i bash -c '
echo ">>> Edit /etc/kubernetes/manifests/kube-apiserver.yaml"
echo ">>> Change: --audit-log-maxbackup=1"
'

echo ">>> Copy q17_policy.yaml to /etc/kubernetes/audit/policy.yaml"
sudo cp q17_policy.yaml /etc/kubernetes/audit/policy.yaml

# Clear audit log
sudo bash -c 'echo > /etc/kubernetes/audit/logs/audit.log'

echo ">>> Verify apiserver restarts cleanly:"
echo "watch kubectl get pods -n kube-system | grep apiserver"

echo ">>> Check new entries:"
echo "cat /etc/kubernetes/audit/logs/audit.log | yq -p json -o json | head -50"
