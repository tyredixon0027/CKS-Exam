#!/bin/bash
# Question 12 — Permission Escape via Restricted Context
# Node: controlplane
# NOTE: replace <pod-name> with the actual pod name found during investigation
set -e

mkdir -p /opt/course/12

# Switch to restricted context
kubectl config use-context restricted@infra-prod

# Check what permissions this user has
kubectl auth can-i --list -n restricted

# Try direct secret access (likely forbidden)
kubectl get secret secret1 -n restricted || true

# Check for alternative access paths (roles, rolebindings, serviceaccounts)
kubectl get rolebindings,clusterrolebindings -n restricted -o wide
kubectl get pods -n restricted

echo ">>> If secrets are mounted in a pod, exec in and read them:"
echo "kubectl exec -n restricted <pod-name> -- env | grep -i pass"
echo "kubectl exec -n restricted <pod-name> -- cat /var/run/secrets/..."

echo ">>> OR if accessible via API:"
kubectl get secret secret1 -n restricted -o jsonpath='{.data.password-key}' | base64 -d > /opt/course/12/secret1 || true
kubectl get secret secret2 -n restricted -o jsonpath='{.data.password-key}' | base64 -d > /opt/course/12/secret2 || true
kubectl get secret secret3 -n restricted -o jsonpath='{.data.password-key}' | base64 -d > /opt/course/12/secret3 || true

# Switch back to default context
kubectl config use-context kubernetes-admin@kubernetes
