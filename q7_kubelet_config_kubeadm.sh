#!/bin/bash
# Question 7 — KubeletConfiguration Update (Kubeadm Way)
# Node: controlplane + node01
set -e

echo "### On controlplane ###"
cat << 'CP_STEPS'
sudo -i
kubectl edit cm kubelet-config -n kube-system
# Under data.kubelet add:
#   containerLogMaxSize: 5Mi
#   containerLogMaxFiles: 3

kubeadm upgrade node phase kubelet-config
systemctl restart kubelet
systemctl status kubelet
CP_STEPS

echo "### On node01 ###"
cat << 'NODE01_STEPS'
ssh node01
sudo -i
kubeadm upgrade node phase kubelet-config
systemctl restart kubelet
systemctl status kubelet
NODE01_STEPS

echo "### Verify on both nodes ###"
cat /var/lib/kubelet/config.yaml | grep -i log
