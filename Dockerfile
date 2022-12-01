FROM alpine:latest
WORKDIR /workdir
ENV HOME=/root
ENV LANG=ja_JP.UTF-8
ENV LC_CTYPE=ja_JP.UTF-8
ENV TROFFONTS=/usr/share/fonts/ipafont:/usr/share/fonts/ipaexfont
RUN apk update \
  && apk add --upgrade \
     heirloom-doctools \
     heirloom-doctools-doc \
     bash bmake \
     font-ipa font-ipaex \
     perl \
  && rm -f /var/cache/apk/*
COPY inputrc $HOME/.inputrc
COPY bashrc $HOME/.bashrc
CMD [ "bash" ]
