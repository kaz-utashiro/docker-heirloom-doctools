FROM alpine:latest
WORKDIR /workdir
RUN apk update \
  && apk add --upgrade \
     heirloom-doctools \
     heirloom-doctools-doc \
     bash bmake \
     font-ipa font-ipaex
CMD [ "bash" ]
