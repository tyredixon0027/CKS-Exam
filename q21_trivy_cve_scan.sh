#!/bin/bash
# Question 21 — Trivy Image CVE Scan
# Node: controlplane (main terminal)
# Scan for CVE-2020-10878 or CVE-2020-1967
set -e

mkdir -p /opt/course/21

IMAGES=(
  "nginx:1.16.1-alpine"
  "k8s.gcr.io/kube-apiserver:v1.18.0"
  "k8s.gcr.io/kube-controller-manager:v1.18.0"
  "docker.io/weaveworks/weave-kube:2.7.0"
)

> /opt/course/21/good-images

for img in "${IMAGES[@]}"; do
  echo ">>> Scanning $img"
  result=$(trivy image --severity HIGH,CRITICAL "$img" 2>/dev/null | grep -E "CVE-2020-10878|CVE-2020-1967" || true)
  if [ -z "$result" ]; then
    echo "$img" >> /opt/course/21/good-images
  else
    echo "$img has a matching CVE:"
    echo "$result"
  fi
done

echo "--- good-images ---"
cat /opt/course/21/good-images
