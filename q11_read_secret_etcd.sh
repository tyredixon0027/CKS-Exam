#!/bin/bash
# Question 11 — Read Secret from ETCD
# Node: controlplane
set -e

mkdir -p /opt/course/11

sudo -i bash -c '
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  get /registry/secrets/team-green/database-access \
  > /opt/course/11/etcd-secret-content
'
cat /opt/course/11/etcd-secret-content

# Get decoded value of key "pass" via kubectl
kubectl get secret database-access -n team-green \
  -o jsonpath='{.data.pass}' | base64 -d \
  > /opt/course/11/database-password

cat /opt/course/11/database-password
