#!/bin/bash
# Question 20 — Cluster Upgrade (1.32.5 -> 1.33.1)
# Node: controlplane + node01
set -e

echo "### CONTROLPLANE ###"
sudo -i bash -c '
apt-get update
apt-cache show kubeadm | grep 1.33.1
apt-get install -y kubeadm=1.33.1-1.1
kubeadm version
kubeadm upgrade plan
kubeadm upgrade apply v1.33.1
'

kubectl drain controlplane --ignore-daemonsets --delete-emptydir-data

sudo -i bash -c '
apt-get install -y kubelet=1.33.1-1.1 kubectl=1.33.1-1.1
systemctl daemon-reload
systemctl restart kubelet
'

kubectl uncordon controlplane

echo "### NODE01 ###"
cat << 'NODE01_STEPS'
ssh node01
sudo -i
apt-get update
apt-get install -y kubeadm=1.33.1-1.1
kubeadm upgrade node
NODE01_STEPS

echo ">>> Back on controlplane - drain node01"
kubectl drain node01 --ignore-daemonsets --delete-emptydir-data

cat << 'NODE01_UPGRADE'
# On node01 - upgrade kubelet and kubectl
apt-get install -y kubelet=1.33.1-1.1 kubectl=1.33.1-1.1
systemctl daemon-reload
systemctl restart kubelet
NODE01_UPGRADE

echo ">>> Back on controlplane - uncordon"
kubectl uncordon node01

# Verify all nodes on 1.33.1
kubectl get nodes
