# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Install Cloudflared based on architecture
ARG BUILD_ARCH
ARG CLOUDFLARED_VERSION="2026.2.0"
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
