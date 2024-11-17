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

# Copy root filesystem
COPY rootfs /

# Set the working directory
WORKDIR /