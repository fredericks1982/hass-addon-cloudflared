# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Install tempio
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

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
            "https://github.com/cloudflare/cloudflared/releases/download/2025.4.2/cloudflared-linux-${CLOUDFLARED_ARCH}" && \
        chmod +x /usr/local/bin/cloudflared; \
    else \
        echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1; \
    fi

# Copy root filesystem
COPY rootfs /

# Set the working directory
WORKDIR /

#ENTRYPOINT ["/usr/local/bin/cloudflared" "--no-autoupdate"]