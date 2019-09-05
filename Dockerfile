ARG ALPINE_TAG=3.9

FROM alpine:$ALPINE_TAG

ENV ENV="/etc/profile"

SHELL ["/bin/sh", "-exc"]

RUN apk upgrade --no-cache; \
    apk add --no-cache su-exec tzdata;

COPY rootfs/ /
