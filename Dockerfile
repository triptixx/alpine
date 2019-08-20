ARG ALPINE_TAG=3.10

FROM alpine:$ALPINE_TAG

SHELL ["/bin/sh", "-exc"]

RUN apk upgrade --no-cache; \
    apk add --no-cache su-exec tzdata;
