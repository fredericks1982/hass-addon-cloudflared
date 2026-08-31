<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->

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
