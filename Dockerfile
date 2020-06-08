FROM varnish:6.4

RUN apt-get update -qq && \
  apt-get install -y \
    git build-essential autotools-dev automake libtool ncurses-dev pkg-config python-docutils \
    varnish-dev;

RUN git clone --depth 1 -b 6.4 --single-branch https://github.com/varnish/varnish-modules /tmp/varnish-modules; \
  cd /tmp/varnish-modules; \
  ./bootstrap; \
  ./configure; \
  make; \
  make install; \
  make check;

EXPOSE 80 8443
CMD []
