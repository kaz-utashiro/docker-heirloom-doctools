FROM alpine:latest
WORKDIR /workdir
RUN apk update \
  && apk add --upgrade \
     heirloom-doctools \
     heirloom-doctools-doc \
     bash bmake \
     font-ipa font-ipaex \
  && rm -f /var/cache/apk/*
COPY inputrc $HOME/.inputrc
CMD [ "bash" ]