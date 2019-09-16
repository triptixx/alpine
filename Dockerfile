ARG ALPINE_TAG=3.10

FROM alpine:${ALPINE_TAG}

ARG ALPINE_TAG

LABEL org.label-schema.name="Alpine Linux" \
      org.label-schema.description="Alpine Linux base image" \
      org.label-schema.url="https://github.com/gliderlabs/docker-alpine" \
      org.label-schema.version=${ALPINE_TAG}

ENV ENV="/etc/profile"

SHELL ["/bin/sh", "-exc"]

RUN apk upgrade --no-cache; \
    apk add --no-cache su-exec tzdata; \
    ls -al /github/workspace;

COPY rootfs/ /
