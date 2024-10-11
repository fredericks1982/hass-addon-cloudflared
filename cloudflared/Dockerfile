# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Set build arguments
ARG TEMPIO_VERSION BUILD_ARCH

# Install necessary packages and tempio
RUN \
    apk add --no-cache curl tzdata && \
    curl -sSLf -o /usr/bin/tempio \
        "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}" && \
    chmod +x /usr/bin/tempio

# Install Cloudflared based on architecture
RUN \
    CLOUDFLARED_ARCH=$(case "${BUILD_ARCH}" in \
        "amd64")  echo "amd64" ;; \
        "i386")   echo "386" ;; \
        "armhf")  echo "arm" ;; \
        "armv7")  echo "arm" ;; \
        "aarch64") echo "arm64" ;; \
        *) echo "unsupported" ;; \
    esac) && \
    if [ "$CLOUDFLARED_ARCH" != "unsupported" ]; then \
        curl -sSL -o /usr/local/bin/cloudflared \
            "https://github.com/cloudflare/cloudflared/releases/download/2024.10.0/cloudflared-linux-${CLOUDFLARED_ARCH}" && \
        chmod +x /usr/local/bin/cloudflared; \
    else \
        echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1; \
    fi

# Copy root filesystem
COPY rootfs /

# Create necessary directories
RUN mkdir -p /etc/cloudflared

# Set the working directory
WORKDIR /etc/cloudflared

# Set the default command
# CMD ["cloudflared", "tunnel", "--no-autoupdate", "run", "--token", "eyJhIjoiZTNkMTFlNDZiOGU4MzZhZGY1NWM4NjRmODk5M2NlNDEiLCJ0IjoiNmRlYmYwNDEtMzc0OC00OTllLWIzNTktMDY4ZGIyZDA5MzI4IiwicyI6Ik1EUTJNbVJsWVRFdE56UTNOUzAwWWprMExXRTROamN0WkRFNFlXVmtaakV5WTJJeCJ9"]