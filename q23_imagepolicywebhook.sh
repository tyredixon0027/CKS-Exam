#!/bin/bash
# Question 23 — ImagePolicyWebhook
# Node: controlplane
# Requires: q23_admission-config.yaml in same directory
set -e

sudo -i bash -c '
# Backup apiserver manifest first
cp /etc/kubernetes/manifests/kube-apiserver.yaml /etc/kubernetes/kube-apiserver-backup.yaml

mkdir -p /opt/course/23/webhook
'

sudo cp q23_admission-config.yaml /opt/course/23/webhook/admission-config.yaml

cat << 'APISERVER_EDIT'
>>> Edit /etc/kubernetes/manifests/kube-apiserver.yaml

Add to spec.containers.command:
- --enable-admission-plugins=NodeRestriction,ImagePolicyWebhook
- --admission-control-config-file=/etc/kubernetes/webhook/admission-config.yaml

Add to spec.containers.volumeMounts:
- name: webhook
  mountPath: /etc/kubernetes/webhook
  readOnly: true

Add to spec.volumes:
- name: webhook
  hostPath:
    path: /opt/course/23/webhook
    type: DirectoryOrCreate
APISERVER_EDIT

echo ">>> Watch for apiserver to restart:"
echo "watch crictl ps | grep apiserver"

echo ">>> Test: image with 'danger-danger' should be blocked"
echo "kubectl run test --image=danger-danger:latest"

echo ">>> Normal image should work"
echo "kubectl run test2 --image=nginx:latest"
