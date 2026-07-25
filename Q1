#!/bin/bash
# Question 1 — Contexts & Certificate Extraction
# Node: controlplane
set -e

mkdir -p /opt/course/1

# Write all context names to file
kubectl config get-contexts -o name > /opt/course/1/contexts
echo "--- contexts ---"
cat /opt/course/1/contexts

# Extract and decode the certificate for user restricted@infra-prod
kubectl config view --raw -o jsonpath='{.users[?(@.name=="restricted@infra-prod")].user.client-certificate-data}' \
  | base64 -d > /opt/course/1/cert
echo "--- cert ---"
cat /opt/course/1/cert
