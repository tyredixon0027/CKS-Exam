#!/bin/bash
# Question 19 — Immutable Container Filesystem
# Node: controlplane
# NOTE: replace <container-name> and <image> in the added securityContext/volumeMounts block
set -e

cp /opt/course/19/immutable-deployment.yaml /opt/course/19/immutable-deployment-new.yaml

cat << 'ADD_TO_SPEC'
>>> Edit /opt/course/19/immutable-deployment-new.yaml
>>> Add to the container spec:

spec:
  containers:
  - name: <container-name>
    image: <image>
    securityContext:
      readOnlyRootFilesystem: true
    volumeMounts:
    - name: tmp-vol
      mountPath: /tmp
  volumes:
  - name: tmp-vol
    emptyDir: {}
ADD_TO_SPEC

kubectl apply -f /opt/course/19/immutable-deployment-new.yaml

# Verify
kubectl get pods -n team-purple
echo ">>> kubectl describe pod <immutable-pod> -n team-purple | grep -i readonly"
