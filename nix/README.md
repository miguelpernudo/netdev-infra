Declarative multi-host configuration for a personal homelab and daily driver workstation. Two distinct machines managed from a single unified flake, eliminating configuration duplication.

---

## Hosts

### 🖥 Strata (Dell OptiPlex 3020)

**Role:** Headless network homelab server.  
**Resources:** Intel Core i5-4590, 6 GB RAM.  
**Status:** Active development.

**Key technologies:**
- **Provisioning:** `nixos-anywhere` + `disko` for automated disk partitioning and remote installation.
- **Networking:** WireGuard VPN endpoint, strict nftables firewall, SSH access restricted to LAN/VPN only.
- **QoS:** HTB traffic shaping via `tc`, it prioritises SSH, DNS, HTTPS, and WireGuard; rate-limits bulk traffic.
- **Observability:** Prometheus + Grafana for node metrics; eBPF for on-demand kernel analysis.
- **Containerisation:** Docker CE with Compose v2, buildKit enabled, automatic cleanup.

---

### 💻 Anatta (ThinkPad T14 Gen1)

**Role:** Daily driver workstation. Development, gaming, class, and *remote builder for Strata*.  
**Desktop Stack:** GNOME 50 on Wayland, and home manager.  
**Status:** Stable.


**Key technologies:**
- **Development:** Micro editor, VSCodium, Go toolchain, Ansible.
- **Shell:** Custom bash functions (`nixreb`, `nixremote`, `nixdry`, `nixupg`, `nixclean`) for workflow efficiency.
- **Terminal:** Ghostty with oceanic theme.

---

## Secrets Management

All secrets are encrypted with **sops-nix** using age keys. Each host has its own encrypted file under `secrets/`:

Secrets are decrypted at build time and never stored in plaintext. The CI pipeline (`gitleaks`) audits every push for accidental secret leakage.
