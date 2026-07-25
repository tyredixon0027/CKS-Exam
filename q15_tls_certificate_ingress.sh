#!/bin/bash
# Question 15 — TLS Certificate for Nginx Ingress
# Node: controlplane
set -e

# Create a TLS secret from the provided cert and key
kubectl create secret tls secure-tls \
  --key=/opt/course/15/tls.key \
  --cert=/opt/course/15/tls.crt \
  -n team-pink

echo ">>> Now run: kubectl edit ingress secure -n team-pink"
echo ">>> Under spec.tls add/update:"
echo "# tls:"
echo "# - hosts:"
echo "#   - secure-ingress.test"
echo "#   secretName: secure-tls"

# Test with curl
curl -kv https://secure-ingress.test:31443/app
curl -kv https://secure-ingress.test:31443/api
