# Cloudflare Tunnel client

Client for Cloudflare Tunnel, a tunneling daemon that proxies traffic from the
Cloudflare network to your origins.

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg

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