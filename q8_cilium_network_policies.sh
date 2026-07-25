#!/bin/bash
# Question 8 — CiliumNetworkPolicies (team-orange)
# Node: controlplane
# Requires: q8_p1.yaml, q8_p2.yaml, q8_p3.yaml in same directory
set -e

kubectl apply -f q8_p1.yaml -f q8_p2.yaml -f q8_p3.yaml

echo ">>> Test connectivity:"
echo "kubectl -n team-orange exec <messenger-pod> -- curl database"
