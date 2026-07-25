#!/bin/bash
# Question 18 — SBOM Generation & Vulnerability Scanning
# Node: controlplane
set -e

mkdir -p /opt/course/18

# 1. Generate SPDX-JSON SBOM using bom
bom generate \
  --image registry.k8s.io/kube-apiserver:v2.32.0 \
  --format json \
  -o /opt/course/18/sbom1.json
cat /opt/course/18/sbom1.json | head -20

# 2. Generate CycloneDX SBOM using trivy
trivy image \
  --format cyclonedx \
  --output /opt/course/18/sbom2.json \
  registry.k8s.io/kube-controller-manager:v1.31.0
cat /opt/course/18/sbom2.json | head -20

# 3. Scan existing SBOM for vulnerabilities
trivy sbom \
  --format json \
  --output /opt/course/18/sbom_check_result.json \
  /opt/course/18/sbom_check.json
cat /opt/course/18/sbom_check_result.json | yq -p json -o json
