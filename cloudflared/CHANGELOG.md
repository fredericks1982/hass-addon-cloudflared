<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->

## 2026.10.2

- Bump cloudflared to 2026.10.5
- Log the cloudflared version at startup
- Pass the tunnel token via the `TUNNEL_TOKEN` environment variable instead of the command line, so it is not visible in the process list

## 2026.10.1

- Bump cloudflared to 2026.10.4, which includes security fixes:
  - Metrics server no longer exposes `/debug/vars`, which could leak the tunnel token to local processes (VULN-176088)
  - Built with Go 1.27.3, including the fix for GO-2026-6600

## 2026.10.0

- Bump cloudflared to 2026.10.0

## 2026.9.0

- Map the app configuration folder read-only at `/config`, so a private CA certificate can be referenced by the Cloudflare Tunnel "CA Pool" origin setting (no change for existing setups)

## 2026.8.0

- Bump cloudflared to 2026.8.3

## 2026.7.0

- Bump cloudflared to 2026.7.3

## 2026.5.0

- Bump cloudflared to 2026.5.1

## 2026.4.0

- Bump cloudflared to 2026.3.0
- Restrict default workflow permissions in builder workflow (security hardening)

## 2026.2.2

- Disable AppArmor profile to fix boot loop / segfault (issue #41)

## 2026.2.1

- Re-enable AppArmor profile with proper cloudflared-specific permissions
- Update documentation to reflect Cloudflare UI navigation changes
- Clean up build configuration

## 2026.2.0

- Bump cloudflared to 2026.2.0
- Drop i386, armhf, and armv7 architecture support (no longer supported by Home Assistant builder)
