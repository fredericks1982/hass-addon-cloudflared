# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

LABEL \
    org.opencontainers.image.title="Home Assistant Add-on: Cloudflare Tunnel client" \
    org.opencontainers.image.description="Client for Cloudflare Tunnel, a tunneling daemon that proxies traffic from the Cloudflare network to your origins." \
    org.opencontainers.image.source="https://github.com/fredericks1982/hass-addon-cloudflared" \
    org.opencontainers.image.licenses="Apache License 2.0"

# Install Cloudflared based on architecture
ARG BUILD_ARCH
ARG CLOUDFLARED_VERSION="2026.7.3"
RUN \
    CLOUDFLARED_ARCH=$(case "${BUILD_ARCH}" in \
        "amd64")  echo "amd64" ;; \
        "aarch64") echo "arm64" ;; \
        *) echo "unsupported" ;; \
    esac) && \
    if [ "$CLOUDFLARED_ARCH" != "unsupported" ]; then \
        curl -sSL -o /usr/local/bin/cloudflared \
            "https://github.com/cloudflare/cloudflared/releases/download/${CLOUDFLARED_VERSION}/cloudflared-linux-${CLOUDFLARED_ARCH}" && \
        chmod +x /usr/local/bin/cloudflared; \
    else \
        echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1; \
    fi

# Copy root filesystem
COPY rootfs /

# Set the working directory
WORKDIR /

# Disable autoupdate and prefer IPv4 by default
ENV NO_AUTOUPDATE=true \
    TUNNEL_EDGE_IP_VERSION=4
