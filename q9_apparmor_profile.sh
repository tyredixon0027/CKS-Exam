#!/bin/bash
# Question 9 — AppArmor Profile
# Node: node01 (via ssh) + controlplane
# Requires: q9_apparmor-deployment.yaml in same directory
# NOTE: replace <profile-name> in the yaml annotation and below
set -e

echo "### On node01 - install AppArmor profile ###"
cat << 'NODE01_STEPS'
ssh node01
sudo -i
cat /opt/course/9/profile   # view profile name at top (e.g., "profile k8s-apparmor-example-deny-write")
apparmor_parser -q /opt/course/9/profile
aa-status | grep <profile-name>
NODE01_STEPS

echo "### On controlplane - label node ###"
kubectl label node node01 security=apparmor
kubectl get node node01 --show-labels | grep apparmor

echo "### Apply Deployment (edit q9_apparmor-deployment.yaml first with correct profile name) ###"
kubectl apply -f q9_apparmor-deployment.yaml

echo "### Write pod logs to file ###"
mkdir -p /opt/course/9
kubectl logs -n default -l app=apparmor > /opt/course/9/logs
cat /opt/course/9/logs
