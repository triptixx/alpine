ARG ALPINE_TAG=3.10
ARG S6_VER=1.22.1.0

FROM alpine:${ALPINE_TAG} AS builder

ARG S6_VER

WORKDIR /s6-src
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-amd64.tar.gz .
RUN mkdir -p /output; \
    tar xzf s6-overlay-amd64.tar.gz -C /output/

COPY *.sh /output/etc/profile.d/

#=============================================================

FROM alpine:${ALPINE_TAG}

ARG ALPINE_TAG
ENV ENV="/etc/profile"

LABEL org.label-schema.name="Alpine-s6 Linux" \
      org.label-schema.description="Alpine S6-Overlay Linux base image" \
      org.label-schema.url="https://github.com/gliderlabs/docker-alpine" \
      org.label-schema.version=${ALPINE_TAG}

COPY --from=builder /output/ /

SHELL ["/bin/sh", "-exc"]

RUN apk upgrade --no-cache;

ENTRYPOINT ["/init"]
