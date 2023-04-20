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
     ghostscript \
     perl perl-dev perl-app-cpanminus \
  && rm -f /var/cache/apk/*
RUN cd /usr/share/fonts/ipafont    && \
    ln -s ipam.ttf  IPAMincho.ttf  && \
    ln -s ipag.ttf  IPAGothic.ttf  && \
    ln -s ipamp.ttf IPAPMincho.ttf && \
    ln -s ipagp.ttf IPAPGothic.ttf
RUN cd /usr/share/fonts/ipaexfont     && \
    ln -s ipaexm.ttf  IPAexMincho.ttf && \
    ln -s ipaexg.ttf  IPAexGothic.ttf
RUN cpanm -n \
    App::Greple \
    Text::VisualWidth::PP \
    Getopt::EX::Hashed \
    Unicode::EastAsianWidth \
    Moo JSON
COPY inputrc $HOME/.inputrc
COPY bashrc $HOME/.bashrc
CMD [ "bash" ]
