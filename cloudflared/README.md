# Cloudflare Tunnel client

Client for Cloudflare Tunnel, a tunneling daemon that proxies traffic from the
Cloudflare network to your origins. The tunnels are configured in your
[Cloudflare Zero Trust](https://one.dash.cloudflare.com/) dashboard, under
_Networks > Tunnels_.

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg

*Cloudflare Tunnel* provides a secure way to connect to your services without exposing
an external IP address. It establishes an encrypted tunnel between your infrastructure
and Cloudflare's edge, routing traffic through this tunnel rather than over the public
internet. This allows you to securely expose web servers, APIs, and other services to
the internet without opening inbound ports in your firewall.

Key features:
- Secure: End-to-end encrypted connections
- Easy setup: No need for complex firewall rules or IP whitelisting
- Flexible: Can expose HTTP, TCP, and UDP services
- Scalable: Supports load balancing and high availability configurations