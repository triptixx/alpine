ARG ALPINE_TAG=3.14

FROM alpine:${ALPINE_TAG}

ARG ALPINE_TAG
ENV ENV="/etc/profile"

LABEL org.label-schema.name="Alpine Linux" \
      org.label-schema.description="Alpine Linux base image" \
      org.label-schema.url="https://github.com/gliderlabs/docker-alpine" \
      org.label-schema.version=${ALPINE_TAG}

SHELL ["/bin/sh", "-exc"]

RUN apk upgrade --no-cache; \
    apk add --no-cache su-exec tzdata tini

COPY *.sh /etc/profile.d/

ENTRYPOINT ["/sbin/tini" , "--"]
