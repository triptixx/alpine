ARG ALPINE_TAG=3.20
ARG S6_VER=3.2.0.0

FROM alpine:${ALPINE_TAG} AS builder

ARG S6_VER

WORKDIR /s6-src
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-noarch.tar.xz .
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-x86_64.tar.xz .
RUN mkdir -p /output; \
    tar Jxpf s6-overlay-noarch.tar.xz -C /output/; \
    tar Jxpf s6-overlay-x86_64.tar.xz -C /output/

COPY *.sh /output/etc/profile.d/

#=============================================================

FROM alpine:${ALPINE_TAG}

ARG ALPINE_TAG
ENV ENV="/etc/profile" \
    PATH="${PATH}:/command"

LABEL org.label-schema.name="Alpine-s6 Linux" \
      org.label-schema.description="Alpine S6-Overlay Linux base image" \
      org.label-schema.url="https://github.com/gliderlabs/docker-alpine" \
      org.label-schema.version=${ALPINE_TAG}

COPY --from=builder /output/ /

SHELL ["/bin/sh", "-exc"]

RUN apk upgrade --no-cache; \
    apk add --no-cache tzdata

ENTRYPOINT ["/init"]
