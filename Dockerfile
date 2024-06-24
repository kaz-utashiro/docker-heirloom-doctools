FROM "paperist/texlive-ja:latest" AS texlive
FROM alpine:latest

ENV HOME=/root
ENV LANG=ja_JP.UTF-8
ENV LC_CTYPE=ja_JP.UTF-8
ENV PATH=/usr/lib/heirloom-doctools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV MANPATH=/usr/lib/heirloom-doctools/man

RUN apk update \
  && apk add --upgrade \
     heirloom-doctools \
     heirloom-doctools-doc \
     bash bmake make gcc musl-dev \
     font-ipa font-ipaex \
     font-noto-cjk font-noto-cjk-extra \
     ghostscript \
     git inkscape \
     perl perl-dev perl-app-cpanminus \
  && rm -f /var/cache/apk/*
ENV TROFFONTS=/usr/share/fonts/noto:$TROFFONTS

RUN cpanm --installdeps -nq \
    https://github.com/kaz-utashiro/App-Greple-fbsd2.git
RUN ln -s heirloom-doctools.sh.disabled /etc/profile.d/heirloom-doctools.sh
COPY inputrc $HOME/.inputrc
COPY bashrc $HOME/.bashrc

RUN cd /usr/share/fonts/ipafont    && \
    ln -s ipam.ttf  IPAMincho.ttf  && \
    ln -s ipag.ttf  IPAGothic.ttf  && \
    ln -s ipamp.ttf IPAPMincho.ttf && \
    ln -s ipagp.ttf IPAPGothic.ttf
RUN cd /usr/share/fonts/ipaexfont     && \
    ln -s ipaexm.ttf  IPAexMincho.ttf && \
    ln -s ipaexg.ttf  IPAexGothic.ttf
ENV TROFFONTS=/usr/share/fonts/ipafont:/usr/share/fonts/ipaexfont:$TROFFONTS

COPY --from=texlive \
    /usr/local/texlive/20??/texmf-dist/fonts/opentype/public/haranoaji/ \
    /usr/share/fonts/haranoaji/
COPY --from=texlive \
    /usr/local/texlive/20??/texmf-dist/fonts/opentype/public/haranoaji-extra/ \
    /usr/share/fonts/haranoaji-extra/
ENV TROFFONTS=/usr/share/fonts/haranoaji:/usr/share/fonts/haranoaji-extra:$TROFFONTS

RUN fc-cache -fv

WORKDIR /workdir
CMD [ "bash" ]
