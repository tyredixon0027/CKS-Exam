#!/bin/bash
# Question 6 — Binary SHA512 Verification
# Node: controlplane
# Provided hashes (reference - replace with actual values from exam):
#   kube-apiserver:           f417c0555bc0167...
#   kube-controller-manager:  60100cc725e91fe...
#   kube-proxy:               52f9d8ad045f8ee...
#   kubelet:                  4be40f2440619e9...
set -e

cd /opt/course/6/binaries

# Generate sha512 for each binary
sha512sum kube-apiserver
sha512sum kube-controller-manager
sha512sum kube-proxy
sha512sum kubelet

echo ">>> Compare each output against the provided hash"
echo ">>> Delete any binary whose hash does NOT match:"
echo "rm <binary-with-wrong-hash>"

# Verify remaining
ls -la /opt/course/6/binaries
