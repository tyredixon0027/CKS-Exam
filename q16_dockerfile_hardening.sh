#!/bin/bash
# Question 16 — Dockerfile Security Hardening
# Node: controlplane
# NOTE: apply the changes shown in q16_Dockerfile to /opt/course/16/image/Dockerfile first
set -e

cd /opt/course/16/image

# Build as candidate user (not root)
podman build -t registry.killer.sh:5000/image-verify:v2 .

# Test run
podman run registry.killer.sh:5000/image-verify:v2

# Push
podman push registry.killer.sh:5000/image-verify:v2

# Update Deployment
kubectl set image deployment/image-verify \
  image-verify=registry.killer.sh:5000/image-verify:v2 \
  -n team-blue

# Verify rollout
kubectl rollout status deployment/image-verify -n team-blue
