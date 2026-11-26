---
name: homelab
description: Operate krymancer's homelab (Proxmox, k3s, ArgoCD, Traefik, Cloudflare Tunnel, Tailscale). Use when debugging a self-hosted service, adding or changing an app in the cluster, checking ArgoCD sync, touching Terraform for the Proxmox guests, or when the user mentions the homelab, k3s, a *.homelab.krymancer.dev URL or one of its apps.
---

# Homelab

Repo: `{{ .fleet.infra_repo }}`, cloned at `{{ .fleet.infra_dir }}` (clone it there if missing).
Pull first (`git -C {{ .fleet.infra_dir }} pull`). Its `AGENTS.md` is the reference for layout and
patterns. This skill is the procedure.

kubectl needs `KUBECONFIG=~/.kube/config-k3s` (fish sets it; on Windows set it yourself).
That is the **production** cluster.

## Debug a service

1. `kubectl -n argocd get application <app>`: Synced/Healthy? If OutOfSync or Degraded:
   `kubectl -n argocd describe application <app>` and look at the conditions.
2. `kubectl -n <app> get pods,svc,ingress,pvc` and `kubectl -n <app> describe pod <pod>`.
3. `kubectl -n <app> logs deploy/<name> --tail=200` (add `--previous` after a crash).
4. Unreachable URL: check the ingress host, the `homelab-wildcard-tls` secret in the namespace
   (Reflector copies it there only if the namespace is in the reflector lists in
   `k8s/apps/cert-manager/wildcard-cert.yaml`), and the `lan-only` middleware.
5. Metrics and probes: Grafana (`grafana.homelab.krymancer.dev`), Uptime Kuma.

Reading is fine. To fix something, change the repo and push (ArgoCD selfHeal reverts manual
edits). The exception is a runtime action like `kubectl rollout restart` or deleting a stuck pod;
say what you did.

## Add a service

Follow the pattern of an existing app of the same shape (e.g. `k8s/apps/compass`):

1. `k8s/apps/<app>/`: namespace, deployment (image pinned by digest or exact tag), service, pvc
   if stateful, ingress for `<app>.homelab.krymancer.dev` with `secretName: homelab-wildcard-tls`,
   `ingressClassName: traefik`, entrypoint `websecure`, and the `lan-only` middleware unless it
   must be public.
2. `k8s/argocd/apps/<app>.yaml`: Application pointing at that path (`CreateNamespace=true`).
3. Add the namespace to both reflector lists in `k8s/apps/cert-manager/wildcard-cert.yaml`.
4. Secrets: commit a `*-secret.example.yaml`, never the real one. Create the real Secret with
   `kubectl` and tell the user which command to run if it needs a value only they have.
5. Public exposure only through `k8s/apps/cloudflared/configmap.yaml`, and only if the user asks.

## Terraform (Proxmox)

Only from a machine on the LAN (or `hermes`) with the SSH agent loaded. Read `terraform/README.md`
first. Never attach an explicit `provider` to `proxmox_virtual_environment_vm.k3s` (production
VM 200): it would look like a move and could destroy the live cluster. Always show a
`terraform plan` and get the user's OK before `apply`.

## Staging

VM 220 on `alt` (192.168.0.23) is usually stopped. It must never take 192.168.0.20 or run
Pi-hole or cloudflared (`k8s/argocd/staging-root.yaml` excludes them).
