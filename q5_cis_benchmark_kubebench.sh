#!/bin/bash
# Question 5 — CIS Benchmark Remediation (kube-bench)
# Node: controlplane + node01
set -e

echo "### Run kube-bench on controlplane ###"
kube-bench master

echo "### Fix 1: --profiling for kube-controller-manager (controlplane) ###"
cat << 'FIX1'
sudo -i
vi /etc/kubernetes/manifests/kube-controller-manager.yaml
# Add/ensure this flag exists under spec.containers.command:
#   - --profiling=false
# apiserver will restart automatically
FIX1

echo "### Fix 2: Ownership of /var/lib/etcd (controlplane) ###"
chown -R etcd:etcd /var/lib/etcd
stat -c "%U %G" /var/lib/etcd

echo "### Node01 fixes ###"
cat << 'NODE01_FIXES'
ssh node01
sudo -i
kube-bench node

### Fix 3: Permissions of kubelet config
chmod 600 /var/lib/kubelet/config.yaml
stat /var/lib/kubelet/config.yaml

### Fix 4: --client-ca-file for kubelet
cat /var/lib/kubelet/config.yaml | grep clientCA
# If missing, add:
vi /var/lib/kubelet/config.yaml
# Add:  authentication:
#         x509:
#           clientCAFile: /etc/kubernetes/pki/ca.crt
systemctl restart kubelet
systemctl status kubelet
NODE01_FIXES
