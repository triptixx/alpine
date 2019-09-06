ARG ALPINE_TAG=3.10

FROM alpine:$ALPINE_TAG

LABEL org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name="Alpine Linux" \
      org.label-schema.description="Alpine Linux base image" \
      org.label-schema.url="https://github.com/gliderlabs/docker-alpine" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vcs-url=${VCS_URL} \
      org.label-schema.vendor=${VENDOR} \
      org.label-schema.version=${ALPINE_TAG} \
      org.label-schema.schema-version="1.0"

ENV ENV="/etc/profile"

SHELL ["/bin/sh", "-exc"]

RUN apk upgrade --no-cache; \
    apk add --no-cache su-exec tzdata;

COPY rootfs/ /
