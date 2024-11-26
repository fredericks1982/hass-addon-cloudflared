# Build stage
FROM debian:stable-slim AS builder

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Download tempio
ARG TEMPIO_VERSION BUILD_ARCH
RUN curl -sSLf -o /tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}" \
    && chmod +x /tempio

# Download Cloudflared
RUN CLOUDFLARED_ARCH=$(case "${BUILD_ARCH}" in \
        "amd64")  echo "amd64" ;; \
        "i386")   echo "386" ;; \
        "armhf")  echo "arm" ;; \
        "armv7")  echo "arm" ;; \
        "aarch64") echo "arm64" ;; \
        *) echo "unsupported" ;; \
    esac) && \
    if [ "$CLOUDFLARED_ARCH" != "unsupported" ]; then \
        curl -sSL -o /cloudflared \
            "https://github.com/cloudflare/cloudflared/releases/download/2024.11.0/cloudflared-linux-${CLOUDFLARED_ARCH}" && \
        chmod +x /cloudflared; \
    else \
        echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1; \
    fi

# Final stage
ARG BUILD_FROM
FROM $BUILD_FROM

# Copy executables from builder
COPY --from=builder /tempio /usr/bin/tempio
COPY --from=builder /cloudflared /usr/local/bin/cloudflared

# Copy root filesystem
COPY rootfs /

WORKDIR /