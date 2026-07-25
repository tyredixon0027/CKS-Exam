# CKS / CKA Exam Practice Scripts

Each question from the practice exam has its own standalone script (`qN_*.sh`).
Supporting YAML manifests and a Dockerfile are included alongside the scripts
that need them (same filename prefix, e.g. `q8_p1.yaml` is used by `q8_cilium_network_policies.sh`).

## Usage

```bash
chmod +x *.sh
./q1_contexts_certificate.sh
```

Scripts that require values discovered during investigation (pod names, container IDs,
deployment names, profile names, etc.) print `>>> ...` instructions rather than guessing —
fill in the placeholder (e.g. `<container-id>`, `<deployment-name>`) and run the indicated
command manually.

## File list

| Script | Topic |
|---|---|
| q1_contexts_certificate.sh | Contexts & Certificate Extraction |
| q2_falco_investigation.sh | Falco Log Investigation & Remediation |
| q3_apiserver_service_type.sh | APIServer Service Type Change |
| q4_pod_security_standards.sh | Pod Security Standards (Baseline) |
| q5_cis_benchmark_kubebench.sh | CIS Benchmark Remediation (kube-bench) |
| q6_binary_sha512_verification.sh | Binary SHA512 Verification |
| q7_kubelet_config_kubeadm.sh | KubeletConfiguration Update (Kubeadm Way) |
| q8_cilium_network_policies.sh (+ q8_p1/p2/p3.yaml) | CiliumNetworkPolicies |
| q9_apparmor_profile.sh (+ q9_apparmor-deployment.yaml) | AppArmor Profile |
| q10_gvisor_runtimeclass.sh (+ q10_runtimeclass.yaml, q10_gvisor-pod.yaml) | gVisor / RuntimeClass |
| q11_read_secret_etcd.sh | Read Secret from ETCD |
| q12_permission_escape.sh | Permission Escape via Restricted Context |
| q13_networkpolicy_metadata.sh (+ q13_metadata-deny/allow.yaml) | NetworkPolicy: Block Metadata Server |
| q14_find_pod_kill_syscall.sh | Find Pod Using Syscall `kill` |
| q15_tls_certificate_ingress.sh | TLS Certificate for Nginx Ingress |
| q16_dockerfile_hardening.sh (+ q16_Dockerfile) | Dockerfile Security Hardening |
| q17_audit_logging_policy.sh (+ q17_policy.yaml) | Audit Logging Policy |
| q18_sbom_generation_scanning.sh | SBOM Generation & Vulnerability Scanning |
| q19_immutable_filesystem.sh | Immutable Container Filesystem |
| q20_cluster_upgrade.sh | Cluster Upgrade (1.32.5 → 1.33.1) |
| q21_trivy_cve_scan.sh | Trivy Image CVE Scan |
| q22_credential_exposure.sh | Static Analysis: Credential Exposure |
| q23_imagepolicywebhook.sh (+ q23_admission-config.yaml) | ImagePolicyWebhook |
