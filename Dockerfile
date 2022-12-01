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
     bash bmake make gcc musl-dev \
     font-ipa font-ipaex \
     perl perl-dev perl-app-cpanminus \
  && rm -f /var/cache/apk/*
RUN cpanm -n \
    App::Greple \
    Getopt::EX::Hashed \
    Unicode::EastAsianWidth \
    Moo JSON
COPY inputrc $HOME/.inputrc
COPY bashrc $HOME/.bashrc
CMD [ "bash" ]
