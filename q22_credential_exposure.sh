#!/bin/bash
# Question 22 — Static Analysis: Credential Exposure
# Node: controlplane
set -e

# Review all files
ls /opt/course/22/files
cat /opt/course/22/files/*

# Look for:
# - Hardcoded passwords, tokens, API keys in ENV vars
# - Secrets passed as plain-text args/env in YAML
# - Credentials baked into Dockerfile ENV or ARG
# - Private keys or certs embedded directly
grep -rn -i "password\|secret\|token\|api_key\|private_key" /opt/course/22/files/

echo ">>> Based on the grep output above, write offending filenames to /opt/course/22/security-issues"
echo "cat > /opt/course/22/security-issues << EOF"
echo "<filename1>"
echo "<filename2>"
echo "EOF"

# Common patterns to flag:
# - ENV PASSWORD=mysecretpassword in Dockerfile
# - value: mysecret in plain YAML env spec (not referencing a Secret)
# - AWS keys, tokens hardcoded in any file
