#!/bin/bash
# Question 14 — Find Pod Using Syscall `kill`
# Node: controlplane (worker nodes via ssh)
# NOTE: replace <offending-deployment> and <container-id> with real values
set -e

# Check running pods in team-yellow
kubectl get pods -n team-yellow -o wide

echo "### SSH to the node where pods are running ###"
cat << 'NODE_STEPS'
ssh node01
sudo -i

# Use sysdig to detect kill syscall
sysdig -p "%proc.name %container.name %container.id" evt.type=kill and container.name!=host

# OR check with falco logs
journalctl -u falco | grep kill | grep team-yellow

# Match container ID to pod
crictl ps | grep <container-id>
NODE_STEPS

echo "### Back on controlplane - scale deployment to 0 ###"
echo "kubectl scale deployment <offending-deployment> -n team-yellow --replicas=0"

# Verify
kubectl get pods -n team-yellow
