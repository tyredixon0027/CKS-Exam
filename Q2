#!/bin/bash
# Question 2 — Falco Log Investigation & Remediation
# Node: node01 (via ssh from controlplane)
# NOTE: replace <deployment-name>, <namespace>, <container-id> with real values found during investigation
set -e

echo "### Run on node01 ###"
cat << 'NODE01_STEPS'
ssh node01
sudo -i

# Check Falco logs for /etc/passwd modification
journalctl -u falco -f | grep /etc/passwd
# OR
falco -U | grep /etc/passwd

# Match container ID to pod
crictl ps | grep <container-id>
# Note the namespace and pod name
NODE01_STEPS

echo "### Run on controlplane - scale httpd deployment down ###"
cat << 'CP_STEPS_1'
kubectl get pods -A | grep httpd
kubectl scale deployment <deployment-name> -n <namespace> --replicas=0
CP_STEPS_1

echo "### Run on node01 - edit Falco rule ###"
cat << 'NODE01_RULE'
vi /etc/falco/rules.d/falco_custom.yaml
# Update the 'Launch Package Management Process in Container' rule output to:
# output: >
#   Package management process launched (evt_time=%evt.time.ns container_id=%container.id
#   container_name=%container.name user_name=%user.name)

systemctl restart falco
NODE01_RULE

echo "### Collect Falco logs for 20+ seconds (save to controlplane) ###"
cat << 'COLLECT_LOGS'
journalctl -u falco -f > /opt/course/2/falco.log &
sleep 25
kill %1
COLLECT_LOGS

echo "### Find and scale down nginx deployment ###"
cat << 'SCALE_NGINX'
falco -U | grep "Package management"
crictl ps | grep <container-id>
# Note pod/namespace, then on controlplane:
kubectl scale deployment <deployment-name> -n <namespace> --replicas=0

# Verify team-purple pods
kubectl get pods -n team-purple
SCALE_NGINX
