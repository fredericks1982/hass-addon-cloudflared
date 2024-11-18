# Home Assistant Add-on: Cloudflare Tunnel Client

*Cloudflare Tunnel* (formerly Argo Tunnel) provides a secure way to connect to your
services without exposing an external IP address.

This add-on establishes an encrypted tunnel between your infrastructure and Cloudflare's
edge, routing traffic through this tunnel rather than over the public internet. This
allows you to securely expose web servers, APIs, and other services to the internet
without opening inbound ports in your firewall, protecting your traffic from attacks and
simplifying (a lot) the management of your inbound traffic.

## Installation

The installation of this add-on is straightforward and similar to installing any other
Home Assistant add-on.

1. Add the repository URL to your Home Assistant add-on store:
   ```
   https://github.com/fredericks1982/hass-addon-cloudflared
   ```

2. Find the "Cloudflare Tunnel Client" add-on in the list of available add-ons, within the "Cloudflare Tunnel add-on" repository.

3. Click the "Install" button to install the add-on. This will take a while.

4. Switch to the "Configuration" tab and set the Cloudflare Tunnel client token (see the section "Configuration" below).

5. Before starting the add-on, consider enabling:
   - The "Watchdog" option to automatically restart the tunnel if it crashes.
   - The "Start on boot" option to automatically start the tunnel during system boot.

6. Start the add-on.

7. Check the logs of the add-on to verify everything is working correctly.

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

### Option: `token`

This is the Cloudflare Tunnel token and is required for the tunnel to authenticate with Cloudflare's network.

To obtain a token:
1. Log into the [Cloudflare Zero Trust Dashboard](https://one.dash.cloudflare.com/) and select your account
2. Navigate to Networks > Tunnels
3. Create a new tunnel or select and edit an existing one
4. Copy the token provided in the tunnel configuration. The token is mentioned in the page section "Install and run a connector" and is the long string in the form _'aqLhIpotWQ...'_ or similar.

## Changelog & Releases

This repository keeps a change log using [GitHub's releases](https://github.com/fredericks1982/hass-addon-cloudflared/releases) functionality.

Releases follow the Calendar Versioning ([CalVer](https://calver.org/)) format: `YYYY.MM.MICRO`, where:
- `YYYY`: Full year (e.g., 2024)
- `MM`: Short month (e.g., 11)
- `MICRO`: The release number within the month, starting at 0

For example:
- `2024.11.0`: First release in November 2024
- `2024.11.1`: First patch/update in November 2024

## Support

Got questions? Found a bug? Please [open an issue](https://github.com/fredericks1982/hass-addon-cloudflared/issues) on the official repository.

## License

This repository uses the Apache License 2.0. For more details, please see the [LICENSE file](https://github.com/fredericks1982/hass-addon-cloudflared/blob/main/LICENSE) in our GitHub repository.

The Cloudflare Tunnel client (cloudflared) is a product of Cloudflare, Inc. and is subject to their terms and conditions.